import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'common_functions.dart';
import 'package:intl/intl.dart';
String toAllCaps(String text) {
  return text.toUpperCase();
}

Future<void> visitorPassView({
  required String company,
  required String passId,
  required String name,
  required String vCompany,
  required String smartAddress,
  required String mobile,
  required String toMeet,
  required String smartCheckIn,
}) async {
  final pdf = pw.Document();

  // ZPL: PW800 x LL680 @ 203dpi → ~100mm x 85mm
  final pageFormat = PdfPageFormat(
    100 * PdfPageFormat.mm,
    85 * PdfPageFormat.mm,
    marginAll: 0,
  );

  // Label style (small caps label like "VISITOR NAME", "ADDRESS" etc.)
  pw.TextStyle labelStyle() => pw.TextStyle(
    fontSize: 7,
    fontWeight: pw.FontWeight.bold,
    letterSpacing: 0.8,
  );

  pdf.addPage(
    pw.Page(
      pageFormat: pageFormat,
      build: (context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: pw.Stack(
            children: [
              // ── Main left column content ──
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // ── HEADER ROW ──
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('VISITOR PASS', style: labelStyle()),
                          pw.SizedBox(height: 2),
                          pw.Text(
                            company,
                            maxLines: 1,
                            style: pw.TextStyle(
                              fontSize: 15,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // pw.Text(
                      //   '#$passId',
                      //   style: pw.TextStyle(
                      //     fontSize: 11,
                      //     fontWeight: pw.FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),

                  pw.SizedBox(height: 4),
                  // ── Divider 1 ──
                  pw.Divider(thickness: 0.8, height: 1),
                  pw.SizedBox(height: 4),

                  // ── VISITOR NAME ──
                  pw.Text('VISITOR NAME', style: labelStyle()),
                  pw.SizedBox(height: 1),
                  pw.Text(
                    name,
                    maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 1),
                  pw.Text(vCompany, style: pw.TextStyle(fontSize: 11)),

                  pw.SizedBox(height: 4),
                  // ── Divider 2 ──
                  pw.Divider(thickness: 0.8, height: 1),
                  pw.SizedBox(height: 5),

                  // ── ADDRESS + MOBILE side by side with QR on right ──
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // Left: all detail fields
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            // ADDRESS
                            pw.Text('ADDRESS', style: labelStyle()),
                            pw.SizedBox(height: 1),
                            pw.Text(
                              smartAddress,
                              style: pw.TextStyle(fontSize: 11),
                            ),
                            pw.SizedBox(height: 6),

                            // MOBILE
                            pw.Text('MOBILE', style: labelStyle()),
                            pw.SizedBox(height: 1),
                            pw.Text(mobile, style: pw.TextStyle(fontSize: 12)),
                            pw.SizedBox(height: 6),

                            // TO MEET
                            pw.Text('TO MEET', style: labelStyle()),
                            pw.SizedBox(height: 1),
                            pw.Text(toMeet, style: pw.TextStyle(fontSize: 12)),
                            pw.SizedBox(height: 6),

                            // CHECK-IN
                            pw.Text('CHECK-IN', style: labelStyle()),
                            pw.SizedBox(height: 1),
                            pw.Text(
                              smartCheckIn,
                              style: pw.TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),

                      pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.SizedBox(height: 6),
                          pw.BarcodeWidget(
                            barcode: pw.Barcode.qrCode(),
                            data: passId,
                            width: 80,
                            height: 80,
                            drawText: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              pw.Positioned(
                top: 0,
                right: 0,
                child: pw.Text(
                  '#$passId',
                    style: labelStyle()
                  // style: pw.TextStyle(
                  //   fontSize: 10,
                  //   fontWeight: pw.FontWeight.bold,
                  // ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  await Printing.layoutPdf(onLayout: (format) async => pdf.save());
}

Future<void> visitorPassViewOld({
  required String name,
  required String company,
  required String address,
  required String phone,
  required String vistorcheckin,
  required String vsid,
  required String purpose,
  required String meetPerson,
  required String meetCompany,
}) async {
  final pdf = pw.Document();

  final checkinDateTime = DateTime.tryParse(vistorcheckin);
  final formattedCheckin = checkinDateTime != null
      ? DateFormat('dd-MM-yy HH:mm').format(checkinDateTime)
      : vistorcheckin;


  pdf.addPage(
    pw.Page(
      pageFormat:
      PdfPageFormat(10 * PdfPageFormat.cm, 7.6 * PdfPageFormat.cm),
      margin: pw.EdgeInsets.all(6),
      build: (context) {
        pw.Widget infoText(String label, String value) {
          return pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: 50,
                child: pw.Text(
                  '$label ',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                    font: pw.Font.helveticaBold(),
                  ),
                ),
              ),
              pw.Text(
                ': ',
                style: pw.TextStyle(
                  fontSize: 11,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold,
                  font: pw.Font.helveticaBold(),
                ),
                maxLines: 1,
                // overflow: pw.TextOverflow.clip,
              ),
              pw.Expanded(
                child: pw.Text(
                  '$value',
                  style: pw.TextStyle(
                    fontSize: 11,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold,
                    font: pw.Font.helveticaBold(),
                  ),
                  maxLines: 2,
                  // overflow: pw.TextOverflow.clip,
                ),
              )
            ],
          );
        }

        return pw.Stack(
          children: [
            pw.Positioned(right: 5,bottom: 30,child:  pw.BarcodeWidget(
                barcode: pw.Barcode.qrCode(),
                data: vsid,
                width: 60,
                height: 60,
                padding: pw.EdgeInsets.only(top: 6)
            )),
            pw.Padding(
              padding:
              const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 2),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'VISITOR PASS',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 14,
                            font: pw.Font.helveticaBold(),
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.Text(
                          "$vsid   ",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 10,
                            font: pw.Font.helveticaBold(),
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.black,
                          ),
                        ),
                      ]),
                  pw.SizedBox(height: 1),
                  pw.Divider(height: 1, color: PdfColors.black),
                  pw.SizedBox(height: 2),
                  pw.Text(
                    meetCompany.toUpperCase(),
                    textAlign: pw.TextAlign.center,
                    // maxLines: 1,
                    style: pw.TextStyle(
                      fontSize: 14,
                      font: pw.Font.helveticaBold(),
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.SizedBox(height: 2),
                  pw.Divider(height: 1, color: PdfColors.black),
                  pw.SizedBox(height: 2),
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text(
                              name.toUpperCase(),
                              maxLines: 1,
                              style: pw.TextStyle(
                                fontSize: 14,
                                font: pw.Font.helveticaBold(),
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.black,
                              ),
                            ),
                            pw.SizedBox(height: 2),
                            pw.Text(
                              company,
                              maxLines: 1,
                              style: pw.TextStyle(
                                fontSize: 10,
                                font: pw.Font.helveticaBold(),
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.black,
                              ),
                            ),
                            pw.SizedBox(height: 4),
                            infoText('Address', address),
                            pw.SizedBox(height: 8),
                            infoText('Mobile', phone),
                            pw.SizedBox(height: 4),
                            infoText('To Meet', meetPerson),
                            pw.SizedBox(height: 4),
                            infoText('Check-in', formattedCheckin),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  await Printing.layoutPdf(onLayout: (format) async => pdf.save());
}



String passDataZpl({
  required String company,
  required String passId,
  required String name,
  required String vCompany,
  required String address,
  required String mobile,
  required String toMeet,
  required String checkIn,
}) {
  String smartAddress = truncateTextSmart(address);
  String smartCheckIn = formatCheckIn(checkIn);

  return """
^XA
^PW800
^LL680
^LH0,0
^CI28

// ── HEADER ──────────────────────────────────
^CF0,22
^FO40,28^FDVISITOR PASS^FS

^CF0,42
^FO40,60^FD$company^FS

^CF0,32
^FO620,28^FD#$passId^FS

^FO20,108^GB760,2,1^FS

// ── VISITOR NAME ────────────────────────────
^CF0,22
^FO40,122^FDVISITOR NAME^FS

^CF0,52
^FO40,156^FD$name^FS

^CF0,30
^FO40,218^FD$vCompany^FS

^FO20,258^GB760,2,1^FS

// ── ADDRESS ─────────────────────────────────
^CF0,22
^FO40,274^FDADDRESS^FS
^CF0,34
^FO40,302^FD$smartAddress^FS

// ── MOBILE ──────────────────────────────────
^CF0,22
^FO40,346^FDMOBILE^FS
^CF0,36
^FO40,374^FD$mobile^FS

// ── TO MEET ─────────────────────────────────
^CF0,22
^FO40,420^FDTO MEET^FS
^CF0,36
^FO40,448^FD$toMeet^FS

// ── CHECK-IN ────────────────────────────────
^CF0,22
^FO40,494^FDCHECK-IN^FS
^CF0,36
^FO40,522^FD$smartCheckIn^FS

// ── QR CODE (right, no border) ──────────────
^FO560,280
^BQN,2,9
^FDLA,$passId^FS

^XZ
""";
}


