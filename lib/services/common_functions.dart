import 'package:intl/intl.dart';
String formatCheckIn(String input) {
  try {
    final dateTime = DateFormat('dd-MM-yyyy HH:mm:ss').parse(input);
    return DateFormat('dd MMM yyyy, h:mm a').format(dateTime);
  } catch (e) {
    return input; // fallback if parsing fails
  }
}

// String truncateTextSmart(String text, {int maxLength = 32}) {
// if (text.length <= maxLength) return text;
//
// String truncated = text.substring(0, maxLength);
// int lastSpace = truncated.lastIndexOf(' ');
//
// if (lastSpace != -1) {
// truncated = truncated.substring(0, lastSpace);
// }
//
// return '$truncated...';
// }

String truncateTextSmart(String text, {int maxLength = 32}) {
  if (text.length <= maxLength) return text;

  String truncated = text.substring(0, maxLength);

  int lastSpace = truncated.lastIndexOf(' ');
  int lastComma = truncated.lastIndexOf(',');

  // pick the nearest separator (space or comma)
  int cutIndex = lastSpace > lastComma ? lastSpace : lastComma;

  if (cutIndex != -1) {
    truncated = truncated.substring(0, cutIndex);
  }

  return '$truncated...';
}