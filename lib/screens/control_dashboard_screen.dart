import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:visitor_pass_v2/controllers/login_controller.dart';
import 'package:visitor_pass_v2/controllers/visitors_data_controller.dart';
import 'package:visitor_pass_v2/screens/scan_qrcode_mobile_screen.dart';
import 'package:visitor_pass_v2/widgets/custom_report.dart';
import '../config/app_colors.dart';
import '../controllers/custom_drawer_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/date_controller.dart';
import '../widgets/custom_appbar.dart';
import 'package:flutter/services.dart';
import '../widgets/custom_summary_report.dart';
import '../widgets/custom_toggle.dart';
import 'scan_qrcode_desktop_screen.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_header_card.dart';
import '../widgets/custom_loaded.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_list_card.dart';

class ControlDashboardScreen extends StatelessWidget {
  const ControlDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();
    final CustomDrawerController drawerController = Get.put(
      CustomDrawerController(),
    );
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      drawer: Obx(() {
        return CustomDrawer(
          headerTitle: loginController.userRole.value == "Staff"
              ? 'Administrator'
              : 'Security',
          headerSubtitle: 'Welcome',
          drawerWidth: 320,
          borderRadius: 28,
          scanQrTitle: 'Scan Qr Code',
          scanQrSubtitle: 'Scan the QR code for check-in and print pass.',
          onScanQrTap: () => drawerController.onTabChange(1),
          checkInTitle: 'Check In',
          checkInSubtitle: 'Check in list will be seen here',
          onCheckInTap: () => drawerController.onTabChange(2),
          checkOutTitle: 'Check Out',
          checkOutSubtitle: 'Check out list will be seen here',
          onCheckOutTap: () => drawerController.onTabChange(3),
          exitListTitle: 'Exit Report',
          exitListSubtitle: 'Check out list will be seen here for gate out',
          onExitListTap: () => drawerController.onTabChange(4),
          visitorListTitle: 'Visitor Report',
          visitorListSubtitle: 'View and manage the list of visitors',
          onVisitorListTap: () => drawerController.onTabChange(5),
          vistitorEntryTitle: 'Tools',
          visitorEntrySubtitle: 'Visitor Pass QR Code will appear here',
          onVisitorEntryTap: () => drawerController.onTabChange(6),
          summaryReportTitle: 'Summary Report',
          summaryReportSubtitle: 'Overview of Total Entry and Exit Counts',
          onSummaryReportTap: () => drawerController.onTabChange(7),
          logoutTitle: 'Logout',
          logoutSubtitle: 'Switch to another account',
          onLogoutTap: () => drawerController.logout(),
          isSecurity: loginController.userRole.value == "Security",
          isAdmin: loginController.userRole.value == "Staff",
          footer: Padding(
            padding: EdgeInsets.all(16),
            child: Text('v2.0.0', style: TextStyle(color: Colors.grey)),
          ),
        );
      }),

      appBar: CustomAppBar(
        title: loginController.userRole.value == "Staff"
            ? "Administrator Dashboard"
            : "Security Dashboard",
        gradient: const LinearGradient(
          colors: [AppColors.primaryDark, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Obx(() {
            switch (drawerController.tabChange.value) {
              case 1:
                return _qrScan();
              case 2:
                return _visitorsReportV2(context, "Check In Report");
              case 3:
                return _visitorsReportV2(context, "Check Out Report");
              case 4:
                return _visitorsReportV2(context, "Exit Report");
              case 5:
                return _visitorsReportV2(context, "Visitor Report");
              case 6:
                return _qrCodeGen();
              case 7:
                return _summaryReport();
              default:
                return const Center(child: Text("Default Screen"));
            }
          }),
        ],
      ),
    );
  }
}

Widget _visitorsReportV2(BuildContext context, String title) {
  final VisitorsDataController visitorsDataController = Get.find();

  return Expanded(
    child: Obx(() {
      final list = visitorsDataController.checkInList;
      // if (dashboardController.isLoading.value) {
      //   return CustomThreeArchedLoader(size: 60, color: AppColors.primary);
      // }

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeaderCard(
                title: title,
                accentColor: AppColors.primary,
                showAction: false,
                actionColor: AppColors.secondary,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              _date(),
              visitorsDataController.isLoading.value
                  ? Center(
                      child: CustomThreeArchedLoader(
                        size: 60,
                        color: AppColors.primary,
                      ),
                    )
                  : list.isNotEmpty
                  ? CustomReport(
                      data: list,
                      btnText: title,
                      primaryColor: AppColors.primary,
                      dialogHeaderColor: AppColors.primary,
                      detailTileColor: Colors.grey.shade100,
                      sectionTitleColor: Colors.black,
                      // dialogWidth: 150,
                      // dialogHeightFactor: 0.7,
                      cardHeaderTitle: title,
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("No Record Found"),
                      ),
                    ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      );
    }),
  );
}

Widget _qrScan() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size =
              (constraints.maxWidth < 600 ? constraints.maxWidth * 0.9 : 500)
                  .toDouble();

          return SizedBox(
            width: size,
            height: size,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: Colors.black12,
                child: qrScanner(context),
              ),
            ),
          );
        },
      ),
    ),
  );
}

Widget qrScanner(BuildContext context) {
  bool isMobileOrTablet = MediaQuery.of(context).size.width < 1024;

  if (isMobileOrTablet) {
    return ScanQrMobileScreen();
  } else {
    return ScanQrDesktopScreen();
  }
}

Widget _qrCodeGen() {
  final DashBoardController dashboardController = Get.put(
    DashBoardController(),
  );
  return Obx(() {
    if (dashboardController.isLoading.value) {
      return CustomThreeArchedLoader(size: 60, color: AppColors.primary);
    }
    return Expanded(
      child: Column(
        children: [
          CustomHeaderCard(
            title: "Visitor Qr Code",
            accentColor: Colors.blue,
            showAction: false,
            actionColor: AppColors.secondary,
            padding: const EdgeInsets.all(8),
          ),

          ListCard(
            title: "Visitor Entry Form",
            subtitle: "QR Code for Visitor Registration",
            onCardTap: () {
              print("Tapped");
            },
            onActionTap: () {
              dashboardController.generateQrAttender(
                "Visitor Registration",
                "#/visitor",
              );
            },
            leadingIcon: Icons.apartment,
            actionText: "Generate",
            accentColor: AppColors.primary,
          ),
        ],
      ),
    );
  });
}

Widget _summaryReport() {
  final DashBoardController dashboardController = Get.put(
    DashBoardController(),
  );
  final DateController dateController = Get.put(DateController());
  return Obx(() {
    if (dashboardController.isLoading.value) {
      return CustomThreeArchedLoader(size: 60, color: AppColors.primary);
    }
    return Expanded(
      child: Column(
        children: [
          CustomHeaderCard(
            title: "Summary Report",
            accentColor: Colors.blue,
            showAction: false,
            actionColor: AppColors.secondary,
            padding: const EdgeInsets.all(8),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ModernToggleButton(
              option1Label: 'This Month',
              option2Label: 'Last Month',
              initialSelection: true,
              option1Icon: Icons.person_rounded,
              option2Icon: Icons.group_rounded,
              onChanged: (isMonth) async {
                print("Month : $isMonth");

                dateController.setMonth(isMonth);
                await dashboardController.fetchSummaryDetail(
                  dateController.summaryMonths.value,
                );
              },
              selectedColor: AppColors.primary,
              unselectedColor: Colors.grey.shade200,
              minHorizontalWidth: 400,
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: dashboardController.summaryReportList.length,
              itemBuilder: (context, index) {
                final summaryReport =
                    dashboardController.summaryReportList[index];

                return SummaryReportCard(
                  data: summaryReport,
                  showActionButton: false,
                );
              },
            ),
          ),
        ],
      ),
    );
  });
}

Widget _date() {
  DateController dateController = Get.put(DateController());
  final CustomDrawerController drawerController = Get.put(
    CustomDrawerController(),
  );
  VisitorsDataController visitorsDataController = Get.find();

  return Row(
    children: [
      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CommonDropdown<DateFilter>(
            items: dateController.dateFilters,
            selectedValue: dateController.selectedFilter.value,
            labelText: 'Today',
            itemLabel: (item) => item.label,
            onChanged: (value) async {
              print("Date Value : $value");
              dateController.searchController.text = "";
              dateController.setDate(drawerController.optFlag.value, value);
            },
          ),
        ),
      ),

      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            controller: dateController.searchController,
            labelText: "Search...",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Search";
              }
              return null;
            },
            onChanged: (value) {
              print("Value: $value");
              visitorsDataController.fetchVisitorReport(
                drawerController.optFlag,
                dateController.dateFlag,
                dateController.fromDate,
                dateController.toDate,
                value.toString(),
              );
            },
            maxLength: 10,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            filled: true,
            fillColor: Colors.white,
            isRequired: false,
          ),
        ),
      ),
    ],
  );
}
