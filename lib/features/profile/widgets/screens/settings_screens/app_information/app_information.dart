import 'package:amsl_app/features/profile/widgets/screens/settings_screens/app_information/package_license.dart';
import 'package:amsl_app/providers/package_info.dart';
import 'package:amsl_app/themes/section_header_theme.dart';
import 'package:amsl_app/widgets/loading/skeleton_loading_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_license_page/flutter_custom_license_page.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInformation extends StatefulHookConsumerWidget {
  const AppInformation({super.key});

  @override
  ConsumerState<AppInformation> createState() => _AppInformationState();
}

class _AppInformationState extends ConsumerState<AppInformation> {
  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);
    final theme = baseTheme.copyWith(
      textTheme: baseTheme.textTheme.apply(
        displayColor: baseTheme.sectionHeaderTheme.textStyle.color,
        decorationColor: baseTheme.sectionHeaderTheme.textStyle.color,
        bodyColor: baseTheme.sectionHeaderTheme.textStyle.color,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "App Information",
                  style: TextStyle(color: theme.colorScheme.onSurface),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        shape: Border(
          bottom: BorderSide(color: theme.colorScheme.surfaceContainer),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            const Gap(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("App Version", style: theme.sectionHeaderTheme.textStyle),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Text(
                    ref.watch(packageInfoProvider).version,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const Gap(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Verwendete Assets",
                  style: theme.sectionHeaderTheme.textStyle,
                ),
                TextButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse("https://storyset.com/"));
                  },
                  child: Text("Storyset", style: theme.textTheme.titleMedium),
                ),
              ],
            ),
            const Gap(8),
            CustomLicensePage((context, licenseData) {
              return body(licenseData, context, theme);
            }),
            const Gap(16),
          ],
        ),
      ),
    );
  }

  Widget body(
    AsyncSnapshot<LicenseData> licenseDataFuture,
    BuildContext context,
    ThemeData theme,
  ) {
    switch (licenseDataFuture.connectionState) {
      case ConnectionState.done:
        LicenseData licenseData = licenseDataFuture.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verwendete Bibliotheken",
              style: theme.sectionHeaderTheme.textStyle,
            ),
            ...licenseData.packages.map(
              (currentPackage) => TextButton(
                style: const ButtonStyle(alignment: Alignment.centerLeft),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currentPackage, style: theme.textTheme.titleMedium),
                    Text(
                      "${licenseData.packageLicenseBindings[currentPackage]!.length} Lizenzen",
                      style: theme.textTheme.titleSmall,
                    ),
                  ],
                ),
                onPressed: () {
                  List<LicenseEntry> packageLicenses = licenseData
                      .packageLicenseBindings[currentPackage]!
                      .map((binding) => licenseData.licenses[binding])
                      .toList();
                  context.goNamed(
                    "package_license",
                    pathParameters: {"packageId": currentPackage},
                    extra: PackageLicenseData(
                      packageName: currentPackage,
                      licenseEntry: packageLicenses,
                    ),
                  );
                },
              ),
            ),
          ],
        );

      default:
        return SkeletonLoadingWidget();
    }
  }
}
