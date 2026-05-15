import 'dart:io';

import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/journal/models/moods.dart';
import 'package:amsl_app/features/tracking/tracking.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../models/tori/journal/journal_entry.dart';

class PdfGenerator {
  static final log = Logger("PdfGenerator");

  static Future<void> exportMultiplePdfs(
    List<ToriJournalEntry> journals,
  ) async {
    log.finer("Exporting ${journals.length} journal entries");
    trackEvent(
      category: TrackingCategory.journal,
      action: TrackingAction.export,
      name: "all",
    );

    final pdf = pw.Document();

    List<pw.Widget> widgets = [];

    journals.sort((a, b) => a.created.compareTo(b.created));

    for (var journal in journals) {
      pw.Widget widget = await _buildPdf(journal);
      widgets.add(widget);
    }

    for (pw.Widget widget in widgets) {
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) => [widget],
        ),
      );
    }

    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/all_${DateTime.now()}.pdf');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
    file.delete();
  }

  static Future<void> exportSinglePdf(ToriJournalEntry journal) async {
    log.finer("Exporting journal entry");
    trackEvent(
      category: TrackingCategory.journal,
      action: TrackingAction.export,
      name: journal.id,
    );
    final pdf = pw.Document();

    pw.Widget widget = await _buildPdf(journal);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [widget],
      ),
    );

    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${journal.id}.pdf');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
    file.delete();
  }

  static Future<void> openPdf(File file) async {}

  static Future<pw.Widget> _buildPdf(ToriJournalEntry journal) async {
    String svg = await rootBundle.loadString(
      'assets/images/avatar_images/amsl.svg',
    );

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(kNewDateTimeFormat.format(journal.created)),
        ),
        _buildHeader(journal, svg),
        pw.SizedBox(height: 10),
        pw.Divider(),
        pw.SizedBox(height: 10),
        _buildContent(journal),
        pw.SizedBox(height: 50),
        if (journal.focus.isNotEmpty) _buildFocus(journal),
        pw.SizedBox(height: 50),
        if (journal.mood != null) _buildMood(journal),
      ],
    );
  }

  static pw.Widget _buildHeader(ToriJournalEntry journal, String svg) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.SvgImage(svg: svg, height: 70, width: 70),
        pw.Text(
          journal.title ?? journal.content.firstOrNull?.title ?? "",
          softWrap: true,
          style: const pw.TextStyle(fontSize: 24),
        ),
      ],
    );
  }

  static pw.Widget _buildContent(ToriJournalEntry journal) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "Darum ging es:",
          style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: List.generate(
            journal.content.length,
            (index) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(height: 20),
                pw.Text(
                  journal.content[index].title ?? "",
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  journal.content[index].content ?? "",
                  style: const pw.TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildFocus(ToriJournalEntry journal) {
    String string = "";
    for (var element in journal.focus) {
      string += "${element.name}, ";
    }
    string = string.substring(0, string.length - 2);
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "Darauf hast du dich konzentriert:",
          style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 20),
        pw.Text(string, style: const pw.TextStyle(fontSize: 16)),
      ],
    );
  }

  static pw.Widget _buildMood(ToriJournalEntry journal) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "Deine Stimmung war:",
          style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 20),
        pw.Text(
          Moods.get(journal.mood!).data.description,
          style: const pw.TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
