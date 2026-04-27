import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:visitor_pass_v2/controllers/date_controller.dart';
import 'package:visitor_pass_v2/controllers/visitors_data_controller.dart';
import 'package:visitor_pass_v2/models/company_model.dart';
import 'package:visitor_pass_v2/models/visitors_data_model.dart';
import 'package:visitor_pass_v2/widgets/custom_button.dart';
import 'package:intl/intl.dart';
import '../config/app_colors.dart';
import '../controllers/date_controller.dart';
import '../services/common_functions.dart';
import '../services/print_services.dart';
import 'custom_dropdown.dart';
import 'custom_header_card.dart';
import 'custom_toast.dart';
import 'package:data_table_2/data_table_2.dart';

/// ===================== MAIN TABLE WIDGET =====================
class CustomReport extends StatefulWidget {
  final List<VisitorsDataModel> data;

  final Color primaryColor;
  final Color headerTextColor;
  final Color rowColor;
  final Color alternateRowColor;
  final double borderRadius;
  final double columnSpacing;
  final double headingRowHeight;
  final double dataRowHeight;
  final double headerFontSize;
  final double rowFontSize;
  final bool showSerialNumber;
  final bool enableZebraStriping;
  final String emptyMessage;

  final double dialogWidth;
  final double dialogHeightFactor;
  final Color dialogBackgroundColor;
  final Color dialogHeaderColor;
  final Color dialogHeaderTextColor;
  final Color closeIconColor;
  final Color sectionTitleColor;
  final Color labelColor;
  final Color valueColor;
  final Color detailTileColor;
  final double dialogBorderRadius;
  final double detailTileRadius;
  final double sectionTitleFontSize;
  final double labelFontSize;
  final double valueFontSize;
  final String dialogTitle;

  final String cardHeaderTitle;

  final String btnText;

  const CustomReport({
    Key? key,
    required this.data,
    this.primaryColor = const Color(0xFF1565C0),
    this.headerTextColor = Colors.white,
    this.rowColor = Colors.white,
    this.alternateRowColor = const Color(0xFFF5F7FA),
    this.borderRadius = 18,
    this.columnSpacing = 20,
    this.headingRowHeight = 56,
    this.dataRowHeight = 52,
    this.headerFontSize = 14,
    this.rowFontSize = 13,
    this.showSerialNumber = true,
    this.enableZebraStriping = true,
    this.emptyMessage = "No Records Found",
    this.dialogWidth = 500,
    this.dialogHeightFactor = 0.75,
    this.dialogBackgroundColor = Colors.white,
    this.dialogHeaderColor = const Color(0xFF1565C0),
    this.dialogHeaderTextColor = Colors.white,
    this.closeIconColor = Colors.white,
    this.sectionTitleColor = Colors.grey,
    this.labelColor = Colors.grey,
    this.valueColor = Colors.black,
    this.detailTileColor = const Color(0xFFF7F9FC),
    this.dialogBorderRadius = 24,
    this.detailTileRadius = 12,
    this.sectionTitleFontSize = 14,
    this.labelFontSize = 13,
    this.valueFontSize = 14,
    this.dialogTitle = "Attender Details",
    required this.cardHeaderTitle,
    required this.btnText,
  }) : super(key: key);

  @override
  _CustomReportState createState() => _CustomReportState();
}

class _CustomReportState extends State<CustomReport> {
  late List<VisitorsDataModel> filteredData;

  VisitorsDataController visitorsDataController = Get.find();

  @override
  void initState() {
    super.initState();
    filteredData = widget.data;
  }

  String formatTime(String? date) {
    if (date == null || date.isEmpty) return " - ";
    try {
      final parsed = DateFormat('dd/MM/yyyy HH:mm:ss').parse(date);
      return DateFormat('hh:mm').format(parsed);
    } catch (_) {
      return date;
    }
  }

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return " - ";
    try {
      final parsed = DateFormat('dd/MM/yyyy HH:mm:ss').parse(date);
      return DateFormat('dd MMM yy').format(parsed);
    } catch (_) {
      return date;
    }
  }

  String reqTime(String? time) {
    if (time == null || time.isEmpty) return " - ";
    return time;
  }

  String toAllCaps(String text) {
    return text.toUpperCase();
  }



  void _showDialog(VisitorsDataModel item) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.dialogBorderRadius),
        ),
        child: Container(
          height:
              MediaQuery.of(context).size.height * widget.dialogHeightFactor,
          width: widget.dialogWidth,
          decoration: BoxDecoration(
            color: widget.dialogBackgroundColor,
            borderRadius: BorderRadius.circular(widget.dialogBorderRadius),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: widget.dialogHeaderColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(widget.dialogBorderRadius),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Visitor Details",
                        style: TextStyle(
                          color: widget.dialogHeaderTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.print_rounded,
                        color: widget.closeIconColor,
                      ),
                      tooltip: "Print Pass",
                      onPressed: () {
                        visitorPassView(
                          company: toAllCaps(item.toCompanyName!),
                          passId: "${item.vID}",
                          name: toAllCaps(item.vName!),
                          vCompany: "${item.vFrom}",
                          smartAddress: truncateTextSmart(item.vAddress!),
                          mobile: "${item.vMobile}",
                          toMeet: "${item.toWhom}",
                          smartCheckIn: formatCheckIn(item.vCheckIn!),
                        );

                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.close, color: widget.closeIconColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // Body
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.btnText == "Check In Report" &&
                          item.vCheckIn == "") ...[
                        _button(widget.btnText, item),
                      ],
                      if (widget.btnText == "Check Out Report" &&
                          item.vCheckOut == "") ...[
                        _button(widget.btnText, item),
                      ],
                      if (widget.btnText == "Exit Report" &&
                          item.vGateOut == "") ...[
                        _gate(),
                        Obx(() {
                          final selected =
                              visitorsDataController.selectedCompany.value;

                          if (selected != null) {
                            return _button(widget.btnText, item);
                          }
                          return SizedBox();
                        }),
                      ],

                      _section("Visitor Information"),
                      _tile("Name", item.vName),
                      _tile("From", item.vFrom),
                      _tile("Address", item.vAddress),
                      _tile("Mobile", item.vMobile),
                      const SizedBox(height: 20),
                      _section("Company Information"),
                      _tile("Name", item.toCompanyName),
                      _tile("Purpose", item.toPurpose),
                      _tile("Meet", item.toWhom),
                      // _tile("Address", item.attAddr),
                      // _tile("City", item.attCity),
                      // _tile("Pincode", item.attPincode),
                      const SizedBox(height: 20),
                      _section("Visit Information"),

                      _tile("Pass Id", item.vID.toString()),
                      if (item.vCheckIn != "") ...[
                        _tile("Check-In", item.vCheckIn),
                      ],
                      if (item.vCheckOut != "") ...[
                        _tile("Check-Out", item.vCheckOut),
                      ],
                      if (item.vGateOut != "") ...[
                        _tile("Gate-Out", item.vGateOut),
                      ],
                      if (item.gateOutName != "") ...[
                        _tile("Gate Name", item.gateOutName),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      text,
      style: TextStyle(
        fontSize: widget.sectionTitleFontSize,
        fontWeight: FontWeight.bold,
        color: widget.sectionTitleColor,
      ),
    ),
  );

  Widget _gate() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CommonDropdown<CompanyModel>(
        items: visitorsDataController.companyList,
        selectedValue:
            visitorsDataController.companyList.contains(
              visitorsDataController.selectedCompany.value,
            )
            ? visitorsDataController.selectedCompany.value
            : null,
        labelText: 'Gate',
        itemLabel: (CompanyModel item) => item.ccompanyname.toString(),
        onChanged: (value) async {
          visitorsDataController.selectedCompany.value = value;
        },
        isRequired: true,
      ),
    );
  }

  Widget _button(String text, VisitorsDataModel item) {
    String btnValue = "";
    String? actionCode;

    switch (widget.btnText) {
      case "Check In Report":
        btnValue = "Check In";
        actionCode = '2';
        break;

      case "Check Out Report":
        btnValue = "Check Out";
        actionCode = '3';
        break;

      case "Exit Report":
        btnValue = "Exit Gate";
        actionCode = '4';
        break;

      default:
        btnValue = "";
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomButton(
        backgroundColor: AppColors.secondary,
        sufIcon: const Icon(Icons.check, color: Colors.white),
        isEnabled: true,
        text: btnValue,
        onPressed: () async {
          print("Visitor ID: ${item.vID}");

          if (actionCode != null) {
            CustomToast.showLoading(context: context);
            await visitorsDataController.onClickCheckInOut(
              actionCode,
              '${item.vID}',
            );
            CustomToast.hideLoading();
          }

          visitorsDataController.getBack();
        },
      ),
    );
  }

  Widget _tile(String title, String? value) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: widget.detailTileColor,
        borderRadius: BorderRadius.circular(widget.detailTileRadius),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: TextStyle(
                fontSize: widget.labelFontSize,
                color: widget.labelColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value ?? "-",
              style: TextStyle(
                fontSize: widget.valueFontSize,
                color: widget.valueColor,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  List<DataColumn> _buildColumns() {
    return [
      if (widget.showSerialNumber)
        DataColumn(
          label: Text(
            "S.No",
            style: TextStyle(
              color: widget.headerTextColor,
              fontSize: widget.headerFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      _column("Name"),
      _column("From  "),
      _column("Address "),
      _column("Mobile          "),
      _column("Company name   "),
      _column("Meet          "),
      _column("Purpose           "),
      // _column("Mobile        "),
      _column("Check-In      "),
      _column("Check-Out     "),
      _column("Gate Out"),
      _column("Gate Name"),
      _column("Date      "),

      // _column("Pass Id       "),
    ];
  }

  DataColumn _column(String title) {
    return DataColumn(
      label: Container(
        width: 100,
        child: Text(
          title,
          style: TextStyle(
            color: widget.headerTextColor,
            fontSize: widget.headerFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  List<DataRow> _buildRows() {
    DateController dateController = Get.find();

    return List.generate(filteredData.length, (index) {
      final item = filteredData[index];
      final bgColor = widget.enableZebraStriping
          ? (index % 2 == 0 ? widget.rowColor : widget.alternateRowColor)
          : widget.rowColor;

      return DataRow(
        color: MaterialStateProperty.all(bgColor),
        cells: [
          if (widget.showSerialNumber) _cell("${index + 1}", item),
          _cell(item.vName ?? "-", item),
          _cell(item.vFrom ?? "-", item),
          _cell(item.vAddress ?? "-", item),
          _cell(item.vMobile ?? "-", item),
          _cell(item.toCompanyName ?? "-", item),
          _cell(item.toWhom ?? "-", item),
          _cell(item.toPurpose ?? "-", item),
          _cell(dateController.getTime(item.vCheckIn!), item),
          _cell(dateController.getTime(item.vCheckOut!), item),
          _cell(dateController.getTime(item.vGateOut!), item),
          _cell(item.gateOutName ?? "-", item),
          _cell(dateController.getDate(item.vCheckIn!), item),
        ],
      );
    });
  }

  DataCell _cell(String value, VisitorsDataModel item) {
    return DataCell(
      InkWell(
        onTap: () => _showDialog(item),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 200),
          child: Text(value, style: TextStyle(fontSize: widget.rowFontSize)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return Center(
        child: Text(widget.emptyMessage, style: const TextStyle(fontSize: 16)),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card
          // CustomHeaderCard(
          //   title: widget.cardHeaderTitle,
          //   accentColor: Colors.blue,
          //   showAction: false,
          //   actionColor: AppColors.secondary,
          //   padding: const EdgeInsets.symmetric(vertical: 8),
          // ),
          const SizedBox(height: 16),
          // Table
          if (filteredData.isEmpty)
            Center(
              child: Text(
                'No Records Found',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          else
            ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  showCheckboxColumn: false,
                  columnSpacing: widget.columnSpacing,
                  headingRowHeight: widget.headingRowHeight,
                  dataRowHeight: widget.dataRowHeight,
                  headingRowColor: MaterialStateProperty.all(
                    widget.primaryColor,
                  ),
                  columns: _buildColumns(),
                  rows: _buildRows(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
