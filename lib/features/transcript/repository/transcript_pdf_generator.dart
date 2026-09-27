import 'dart:io';

import 'package:amsl_app/constants.dart';
import 'package:amsl_app/features/tracking/tracking.dart';
import 'package:amsl_app/features/transcript/models/transcript_record.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class TranscriptPdfGenerator {
  static final log = Logger("TranscriptPdfGenerator");

  static Future<void> exportRecord(
    TranscriptRecord record, {
    required String userId,
  }) async {
    log.finer("Exporting transcript record ${record.id}");
    trackEvent(
      category: TrackingCategory.profile,
      action: TrackingAction.export,
      name: record.id,
    );

    File? file;
    try {
      final pdf = pw.Document();
      final widget = await _buildPdf(record, userId);

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) => [widget],
        ),
      );

      final bytes = await pdf.save();
      final dir = await getApplicationDocumentsDirectory();
      file = File('${dir.path}/${record.id}.pdf');
      await file.writeAsBytes(bytes);
      await OpenFile.open(file.path);
    } catch (e, stackTrace) {
      log.warning(
        "Failed to export transcript record ${record.id}",
        e,
        stackTrace,
      );
    } finally {
      try {
        await file?.delete();
      } catch (e, stackTrace) {
        log.warning("Failed to delete temporary transcript PDF", e, stackTrace);
      }
    }
  }

  static Future<pw.Widget> _buildPdf(
    TranscriptRecord record,
    String userId,
  ) async {
    String svg = await rootBundle.loadString(
      'assets/images/avatar_images/amsl.svg',
    );

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(kNewDateTimeFormat.format(DateTime.now())),
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.SvgImage(svg: svg, height: 70, width: 70),
            pw.Text(
              record.title,
              softWrap: true,
              style: const pw.TextStyle(fontSize: 24),
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Divider(),
        pw.SizedBox(height: 10),
        pw.Text(record.description, style: const pw.TextStyle(fontSize: 16)),
        pw.SizedBox(height: 50),
        pw.Text("Nutzer-ID: $userId", style: const pw.TextStyle(fontSize: 12)),
      ],
    );
  }
}
