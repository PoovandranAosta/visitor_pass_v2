import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visitor_pass_v2/controllers/custom_drawer_controller.dart';
import 'package:visitor_pass_v2/controllers/visitors_data_controller.dart';

class DateController extends GetxController {
  @override
  void onInit() {
    setDefaultDate();
    setDefaultSummaryMonth();
    super.onInit();
  }

  List<DateFilter> dateFilters = DateFilter.values;

  final VisitorsDataController _visitorsDataController = Get.find();

  Rx<DateFilter?> selectedFilter = Rx<DateFilter?>(null);
  final Rx<String?> fromDate = Rx<String?>(null);
  final Rx<String?> toDate = Rx<String?>(null);

  final Rx<String?> summaryMonths = Rx<String?>(null);

  final RxString dateFlag = '1'.obs;

  final TextEditingController searchController = TextEditingController();

  String get search => searchController.text;

  void setMonth(isThisMonth) {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy/MM/dd');

    if (isThisMonth) {
      final thisMonthFirstDay = DateTime(now.year, now.month, 1);
      summaryMonths.value = formatter.format(thisMonthFirstDay);
    } else {
      final previousMonthFirstDay = DateTime(now.year, now.month - 1, 1);
      summaryMonths.value = formatter.format(previousMonthFirstDay);
    }

    print(summaryMonths.value);
  }

  void setDefaultSummaryMonth(){
    final now = DateTime.now();
    final formatter = DateFormat('yyyy/MM/dd');
    final thisMonthFirstDay = DateTime(now.year, now.month, 1);
    summaryMonths.value = formatter.format(thisMonthFirstDay);
  }

  void setDefaultDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy/MM/dd');

    fromDate.value = formatter.format(now);
    toDate.value = formatter.format(now);
  }

  Future<void> setDate(optFlag, value) async {
    selectedFilter.value = value;

    DateTime? from;
    DateTime? to;
    final now = DateTime.now();

    switch (value!) {
      case DateFilter.today:
        from = now;
        to = now;
        dateFlag.value = '1';
        break;

      case DateFilter.yesterday:
        final y = now.subtract(const Duration(days: 1));
        from = y;
        to = y;
        dateFlag.value = '2';
        break;

      case DateFilter.thisWeek:
        from = now.subtract(const Duration(days: 7));
        to = now;
        dateFlag.value = '3';
        break;

      case DateFilter.thisMonth:
        from = DateTime(now.year, now.month, 1);
        to = now;
        dateFlag.value = '4';
        break;

      case DateFilter.custom:
        DateTimeRange? picked = await showDateRangePicker(
          context: Get.context!,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );

        from = picked?.start;
        to = picked?.end;
        dateFlag.value = '5';
        break;
    }

    fromDate.value = formatDate(from.toString());
    toDate.value = formatDate(to.toString());

    print("${formatDate(from.toString())}");
    print("${formatDate(to.toString())}");
    print("Flag : $dateFlag");
    print("Opt : ${optFlag}");
    _visitorsDataController.fetchVisitorReport(
      optFlag,
      dateFlag,
      formatDate(from.toString()),
      formatDate(to.toString()),
      "",
    );
  }

  String formatDate(String input) {
    DateTime dateTime = DateTime.parse(input);
    return DateFormat('yyyy/MM/dd').format(dateTime);
  }

  String formatSmartDate(String inputDate) {
    try {
      DateTime date = DateFormat('dd-MM-yyyy HH:mm:ss').parse(inputDate);
      DateTime now = DateTime.now();

      Duration diff = now.difference(date);

      if (diff.inSeconds < 60) {
        return "Just now";
      } else if (diff.inMinutes < 60) {
        return "${diff.inMinutes} min ago";
      } else if (diff.inHours < 24 && now.day == date.day) {
        return "Today, ${DateFormat('hh:mm a').format(date)}";
      } else if (diff.inHours < 48 && now.day - date.day == 1) {
        return "Yesterday, ${DateFormat('hh:mm a').format(date)}";
      } else if (diff.inDays < 7) {
        return "${DateFormat('EEEE').format(date)}, ${DateFormat('hh:mm a').format(date)}";
      } else {
        return DateFormat('dd MMM yyyy, hh:mm a').format(date);
      }
    } catch (e) {
      return inputDate;
    }
  }

  String getDate(String input) {
    try {
      DateTime date = DateFormat('dd-MM-yyyy HH:mm:ss').parse(input);
      return DateFormat('dd MMM yyyy').format(date); // 21 Apr 2026
    } catch (e) {
      return input;
    }
  }

  String getTime(String input) {
    try {
      DateTime date = DateFormat('dd-MM-yyyy HH:mm:ss').parse(input);
      return DateFormat('hh:mm').format(date); // 11:09
    } catch (e) {
      return input;
    }
  }

  void resetDate(opt) {
    setDate(opt, DateFilter.today);
  }
}

extension DateFilterExtension on DateFilter {
  String get label {
    switch (this) {
      case DateFilter.today:
        return "Today";
      case DateFilter.yesterday:
        return "Yesterday";
      case DateFilter.thisWeek:
        return "This Week";
      case DateFilter.thisMonth:
        return "This Month";
      case DateFilter.custom:
        return "Custom";
    }
  }
}

enum DateFilter { today, yesterday, thisWeek, thisMonth, custom }
