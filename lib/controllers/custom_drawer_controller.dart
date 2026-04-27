import 'package:get/get.dart';
import 'package:visitor_pass_v2/controllers/date_controller.dart';
import 'package:visitor_pass_v2/controllers/scan_qr_controller.dart';
import 'package:visitor_pass_v2/controllers/visitors_data_controller.dart';
import 'package:visitor_pass_v2/routes/app_routes.dart';

import 'dashboard_controller.dart';

class CustomDrawerController extends GetxController {
  RxInt tabChange = 1.obs;
  final RxString optFlag = '1'.obs;

  final ScanQrController scanQrController = Get.put(ScanQrController());

  final VisitorsDataController visitorsDataController = Get.put(
    VisitorsDataController(),
  );

  final DashBoardController dashBoardController = Get.put(
    DashBoardController(),
  );

  final DateController dataController = Get.put(DateController());

  @override
  void onInit() {
    scanQr();
    super.onInit();
  }

  void logout() {
    Get.offAllNamed(AppRoutes.home);
  }

  void onTabChange(int tabId) {
    tabChange.value = tabId;

    switch (tabId) {
      case 1:
        scanQr();
        print("Scan Qr");
      case 2:
        print("Check In");
        visitorReportV2('1');
        break;
      case 3:
        print("Check Out");
        visitorReportV2('7');
        break;
      case 4:
        print("Exit List");
        visitorReportV2('8');
        break;
      case 5:
        print("Visitor List");
        visitorReportV2('6');
        break;
      case 6:
        print("Visitor Form");
        break;
      case 7:
        print("Summary Form");
        summaryReport();
        break;
      default:
        print("Default Screen");
    }
  }

  Future<void> scanQr() async {
    await scanQrController.fetchCompany();
  }

  Future<void> summaryReport() async {
    await dashBoardController.fetchSummaryDetail(dataController.summaryMonths.value);
  }


  Future<void> visitorReportV2(opt) async {
    optFlag.value = opt;
    dataController.searchController.text="";
    dataController.resetDate(opt);
    // await visitorsDataController.fetchVisitorReport(
    //   optFlag,
    //   dataController.dateFlag,
    //   dataController.fromDate,
    //   dataController.toDate,
    //   "",
    // );
  }
}
