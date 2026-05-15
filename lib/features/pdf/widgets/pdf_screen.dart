import 'package:amsl_app/features/modules/providers/session_provider.dart';
import 'package:amsl_app/features/pdf/repository/pdf_store.dart';
import 'package:amsl_app/models/tori/theme/module_theme.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:open_file/open_file.dart';
import 'package:pdfx/pdfx.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

class PDFScreen extends StatefulHookConsumerWidget {
  static final log = Logger("PDFScreen");
  final String moduleID;
  final String sessionID;

  const PDFScreen({super.key, required this.moduleID, required this.sessionID});

  @override
  ConsumerState<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends ConsumerState<PDFScreen> {
  @override
  Widget build(BuildContext context) {
    final session = ref.read(
      sessionPodProvider(widget.moduleID, widget.sessionID),
    );

    if (session == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.pop();
        }
      });
      return const SizedBox.shrink();
    }
    final module = session.module.target;

    final baseTheme = Theme.of(context);
    final moduleTheme = session.module.target?.theme ?? baseTheme.moduleTheme;

    ThemeData theme = baseTheme.copyWith(
      textTheme: baseTheme.textTheme.apply(
        bodyColor: baseTheme.colorScheme.onSecondary,
        displayColor: baseTheme.colorScheme.onSecondary,
      ),
      extensions: (Map<Object, ThemeExtension<dynamic>>.from(
        baseTheme.extensions,
      )..[moduleTheme.type] = moduleTheme).values,
    );

    final sources = session.sources;

    final tabs = sources.map((e) => Tab(text: e.fileName)).toList();

    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [Text(module!.title, style: theme.textTheme.titleSmall)],
          ),
          backgroundColor: theme.moduleTheme.color,
        ),
        body: DefaultTabController(
          length: tabs.length,
          child: Column(
            children: [
              TabBar(
                tabs: tabs,
                isScrollable: true,
                indicatorColor: theme.moduleTheme.color,
                labelColor: theme.colorScheme.onSurface,
                dividerColor: Colors.transparent,
                tabAlignment: TabAlignment.start,
              ),
              Expanded(
                child: TabBarView(
                  children: sources.map((source) {
                    return PDFViewerTab(fileId: source.fileId);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PDFViewerTab extends StatefulHookConsumerWidget {
  final String fileId;

  const PDFViewerTab({super.key, required this.fileId});

  @override
  ConsumerState<PDFViewerTab> createState() => _PDFViewerTabState();
}

class _PDFViewerTabState extends ConsumerState<PDFViewerTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    super.build(context);

    return ref
        .read(pDFStoreProvider.notifier)
        .loadFile(widget.fileId)
        .build(
          context,
          builder: (context, file) {
            if (file == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  showMessage(
                    context,
                    label: "Die PDF-Datei konnte nicht geladen werden.",
                    error: true,
                  );
                  context.pop();
                }
              });
              return const SizedBox.shrink();
            }
            final controller = PdfControllerPinch(
              document: PdfDocument.openFile(file.path),
            );

            return Stack(
              children: [
                PdfViewPinch(
                  controller: controller,
                  scrollDirection: Axis.vertical,
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: ClipOval(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      color: theme.moduleTheme.color.withAlpha(128),
                      child: IconButton(
                        onPressed: () async {
                          await OpenFile.open(file.path);
                        },
                        icon: Icon(Icons.ios_share, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
  }
}
