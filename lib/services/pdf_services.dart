import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../config/config.dart';
import 'package:pdf/pdf.dart';

class PdfServices {

  Future<void> visitorQrPdf({
    required String title,
    required String url,
  }) async {
    final pdf = pw.Document();

    final qrImage = await QrPainter(
      data: "${Config.siteUrl}$url",
      version: QrVersions.auto,
      gapless: true,
    ).toImageData(250);

    final qrBytes = qrImage!.buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(
            child: pw.Column(
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Text(
                  title.toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 35,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 40),
                pw.Image(pw.MemoryImage(qrBytes), width: 350, height: 350),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

}