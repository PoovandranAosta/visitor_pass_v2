import 'dart:typed_data';
import 'dart:ui';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../config/config.dart';
import 'package:pdf/pdf.dart';

// class PdfServices {
//
//   Future<void> visitorQrPdf({
//     required String title,
//     required String url,
//   }) async {
//     final pdf = pw.Document();
//
//     final qrImage = await QrPainter(
//       data: "${Config.siteUrl}$url",
//       version: QrVersions.auto,
//       gapless: true,
//     ).toImageData(250);
//
//     final qrBytes = qrImage!.buffer.asUint8List();
//
//     pdf.addPage(
//       pw.Page(
//         build: (context) {
//           return pw.Center(
//             child: pw.Column(
//               mainAxisSize: pw.MainAxisSize.min,
//               children: [
//                 pw.Text(
//                   title.toUpperCase(),
//                   style: pw.TextStyle(
//                     fontSize: 35,
//                     fontWeight: pw.FontWeight.bold,
//                   ),
//                 ),
//                 pw.SizedBox(height: 40),
//                 pw.Image(pw.MemoryImage(qrBytes), width: 350, height: 350),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//
//     await Printing.layoutPdf(onLayout: (format) async => pdf.save());
//   }
//
// }

class PdfServices {
  static const String _companyName = "Aosta India Private Limited";
  static final String _siteBaseUrl = Config.siteUrl;

  static const PdfColor _orange = PdfColor.fromInt(0xFFF5A623);
  static const PdfColor _black = PdfColor.fromInt(0xFF1A1A1A);
  static const PdfColor _grey = PdfColor.fromInt(0xFF666666);
  static const PdfColor _line = PdfColor.fromInt(0xFFE0E0E0);
  static const PdfColor _white = PdfColors.white;

  static const List<Map<String, String>> _steps = [
    {"title": "Scan the QR code", "sub": "Using your mobile phone camera."},
    {
      "title": "Enter your details",
      "sub":
          "Personal Info, Purpose of visit and name of the person you are visiting.",
    },
    {
      "title": "Receive your QR code",
      "sub": "You will get your QR code (check WhatsApp if you don't see it).",
    },
    {
      "title": "Show QR at the gate",
      "sub": "Present the QR code to the security officer at the entrance.",
    },
    {
      "title": "Collect your pass",
      "sub": "Security will verify and issue your visitor entry pass.",
    },
  ];

  Future<void> visitorQrPdf({required String url}) async {
    final pdf = pw.Document();

    final qrData = await QrPainter(
      data: "$_siteBaseUrl$url",
      version: QrVersions.auto,
      gapless: true,
      color: const Color(0xFF000000),
      emptyColor: const Color(0xFFFFFFFF),
    ).toImageData(500);
    final qrBytes = qrData!.buffer.asUint8List();

    final now = DateTime.now();
    final monthYear = "${_shortMonth(now.month)} ${now.year}";

    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.zero,
        pageFormat: PdfPageFormat.a4.landscape,
        build: (_) => _buildPage(qrBytes, monthYear),
      ),
    );

    await Printing.layoutPdf(onLayout: (_) async => pdf.save());
  }

  pw.Widget _buildPage(Uint8List qrBytes, String monthYear) {
    return pw.Stack(
      children: [
        // White background
        pw.Positioned.fill(child: pw.Container(color: _white)),

        // Top orange strip
        pw.Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: pw.Container(height: 10, color: _orange),
        ),

        // Bottom orange strip
        pw.Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: pw.Container(height: 10, color: _orange),
        ),

        // Main content
        pw.Positioned.fill(
          child: pw.Padding(
            padding: const pw.EdgeInsets.fromLTRB(36, 22, 36, 22),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Title
                pw.Text(
                  "VISITOR PASS",
                  style: pw.TextStyle(
                    color: _black,
                    fontSize: 52,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.SizedBox(height: 6),
                pw.Container(height: 1.5, color: _orange),
                pw.SizedBox(height: 18),

                // Body
                pw.Expanded(
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // Steps — left
                      pw.Expanded(
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: List.generate(_steps.length, (i) {
                            return pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                // Number circle
                                pw.Container(
                                  width: 26,
                                  height: 26,
                                  decoration: const pw.BoxDecoration(
                                    color: _orange,
                                    shape: pw.BoxShape.circle,
                                  ),
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                    "${i + 1}",
                                    style: pw.TextStyle(
                                      color: _white,
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ),
                                pw.SizedBox(width: 12),
                                pw.Expanded(
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        _steps[i]["title"]!,
                                        style: pw.TextStyle(
                                          color: _black,
                                          fontSize: 13,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      pw.SizedBox(height: 2),
                                      pw.Text(
                                        _steps[i]["sub"]!,
                                        style: const pw.TextStyle(
                                          color: _grey,
                                          fontSize: 11,
                                          lineSpacing: 1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),

                      // Vertical divider
                      pw.Container(
                        width: 1,
                        color: _line,
                        margin: const pw.EdgeInsets.symmetric(horizontal: 24),
                      ),

                      // QR — right
                      pw.Center(
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Container(
                              padding: const pw.EdgeInsets.all(12),
                              decoration: pw.BoxDecoration(
                                color: const PdfColor.fromInt(0xFFF9F9F9),
                                border: pw.Border.all(color: _line, width: 1),
                                borderRadius: const pw.BorderRadius.all(
                                  pw.Radius.circular(8),
                                ),
                              ),
                              child: pw.Image(
                                pw.MemoryImage(qrBytes),
                                width: 220,
                                height: 220,
                              ),
                            ),
                            pw.SizedBox(height: 14),
                            pw.Text(
                              "Scan to Continue...",
                              style: pw.TextStyle(
                                color: _orange,
                                fontSize: 15,
                                fontStyle: pw.FontStyle.italic,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 14),
                pw.Container(height: 1.5, color: _orange),
                pw.SizedBox(height: 10),

                // Footer
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      _companyName,
                      style: pw.TextStyle(
                        color: _black,
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      monthYear,
                      style: const pw.TextStyle(color: _grey, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _shortMonth(int m) => const [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ][m];
}
