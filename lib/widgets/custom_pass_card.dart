// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
//
// class PatientQrInfoCard extends StatefulWidget {
//   final String qrData;
//   final String patientName;
//   final String ward;
//   final String date;
//   final String time;
//   final Color accentColor;
//   final IconData collapsedIcon;
//   final IconData expandedIcon;
//
//   const PatientQrInfoCard({
//     super.key,
//     required this.qrData,
//     required this.patientName,
//     required this.ward,
//     required this.date,
//     required this.time,
//     this.accentColor = Colors.green,
//     this.collapsedIcon = Icons.visibility,
//     this.expandedIcon = Icons.close,
//   });
//
//   @override
//   State<PatientQrInfoCard> createState() => _PatientQrInfoCardState();
// }
//
// class _PatientQrInfoCardState extends State<PatientQrInfoCard> {
//   bool _showDetails = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           /// Header Row
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// QR Code
//               QrImageView(
//                 data: widget.qrData,
//                 size: 90,
//                 backgroundColor: Colors.white,
//               ),
//
//               const SizedBox(width: 16),
//
//               /// Title + subtitle
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Patient QR",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: widget.accentColor,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       "Tap icon to view details",
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               /// Toggle Icon
//               InkWell(
//                 onTap: () {
//                   setState(() {
//                     _showDetails = !_showDetails;
//                   });
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                     color: widget.accentColor.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     _showDetails
//                         ? widget.expandedIcon
//                         : widget.collapsedIcon,
//                     color: widget.accentColor,
//                     size: 20,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//
//           /// Patient Details
//           AnimatedSwitcher(
//             duration: const Duration(milliseconds: 300),
//             child: _showDetails
//                 ? Padding(
//               padding: const EdgeInsets.only(top: 16),
//               child: Column(
//                 children: [
//                   _infoRow("Patient", widget.patientName),
//                   _infoRow("Ward", widget.ward),
//                   _infoRow("Date", widget.date),
//                   _infoRow("Time", widget.time),
//                 ],
//               ),
//             )
//                 : const SizedBox.shrink(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _infoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 3,
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//                 fontSize: 13,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 5,
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VisitorInfoCard extends StatefulWidget {
  final String qrData;
  final String visitorName;
  final String visitorCompany;
  final String company;
  final String toMeet;
  final String purpose;

  final Color accentColor;

  const VisitorInfoCard({
    super.key,
    required this.qrData,
    required this.visitorName,
    required this.visitorCompany,
    required this.company,
    required this.toMeet,
    required this.purpose,
    this.accentColor = Colors.green,
  });

  @override
  State<VisitorInfoCard> createState() => _VisitorInfoCardState();
}

class _VisitorInfoCardState extends State<VisitorInfoCard> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cardWidth = width > 450 ? 420.0 : width * 0.9;

    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Gradient Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(22),
              ),
              gradient: LinearGradient(
                colors: [
                  widget.accentColor,
                  widget.accentColor.withOpacity(0.8),
                ],
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.qr_code_2, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  "Visitor Pass",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => setState(() => showDetails = !showDetails),
                  child: Icon(
                    showDetails ? Icons.close : Icons.info_outline,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// BIG QR
          QrImageView(
            data: widget.qrData,
            size: 240,
            backgroundColor: Colors.white,
          ),

          const SizedBox(height: 14),

          /// Patient Name (Always Visible)
          Text(
            widget.visitorName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 6),

          Text(
            widget.visitorCompany,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),

          /// Expandable Info Section
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: showDetails
                ? Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _infoRow("Company", widget.company),
                        _infoRow("Meet", widget.toMeet),
                        _infoRow("Purpose", widget.purpose),
                      ],
                    ),
                  )
                : const SizedBox(height: 16),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
