import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_pass_v2/controllers/custom_drawer_controller.dart';
import 'package:visitor_pass_v2/controllers/date_controller.dart';
import 'package:visitor_pass_v2/models/visitors_data_model.dart';

import '../models/company_model.dart';
import '../models/pass_data_model.dart';
import '../services/api_function.dart';

class VisitorsDataController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  fetchData() {
    fetchCompany();
  }

  RxList<CompanyModel> companyList = <CompanyModel>[].obs;

  Rx<CompanyModel?> selectedCompany = Rx(null);

  RxList<PassDataModel> passDetailList = <PassDataModel>[].obs;

  // Loading
  final isLoadingPassDetail = false.obs;

  Future<void> fetchCompany() async {
    final data = await _apiFunction.fetchCompanyList({
      "strQuery": "exec ASTIL_MApps.dbo.SP_tblvstrcompany_MAPPS @opt = 1",
      "strCon": "EMR_CONSTR",
    });
    companyList.assignAll(data);
    print("Company List : $companyList");
  }

  final ApiFunction _apiFunction = ApiFunction();

  final isLoading = false.obs;

  RxList<VisitorsDataModel> checkInList = <VisitorsDataModel>[].obs;
  RxList<VisitorsDataModel> checkOutList = <VisitorsDataModel>[].obs;
  RxList<VisitorsDataModel> exitList = <VisitorsDataModel>[].obs;

  // CustomDrawerController drawerController = Get.find();
  CustomDrawerController get drawerController =>
      Get.find<CustomDrawerController>();

  DateController get dateController => Get.find<DateController>();

  RxString actionClicked = "".obs;

  Future<void> fetchVisitorReport(
    opt,
    dateFlag,
    fromDate,
    toDate,
    search,
  ) async {
    isLoading.value = true;
    final data;
    if (dateFlag != "5") {
      data = await _apiFunction.fetchReport({
        "strQuery":
            "exec astil_mapps.dbo.sp_visitors_checking @opt = '$opt',@flg = $dateFlag, @search = '$search', @dcheckin = '$fromDate'",
        "strCon": "EMR_CONSTR",
      });
    } else {
      data = await _apiFunction.fetchReport({
        "strQuery":
            "exec astil_mapps.dbo.sp_visitors_checking @opt = '$opt',@flg = $dateFlag, @search = '$search', @dcheckin = '$fromDate',@todate = '$toDate'",
        "strCon": "EMR_CONSTR",
      });
    }

    checkInList.assignAll(data);
    isLoading.value = false;
  }

  Future<void> onClickCheckInOut(opt, passId) async {
    if (opt != "4") {
      actionClicked.value = await _apiFunction.checkInOutExit({
        "strQuery":
            "exec astil_mapps.dbo.sp_visitors_checking @opt = '$opt',@vid='$passId'",
        "strCon": "EMR_CONSTR",
      });
    } else {
      actionClicked.value = await _apiFunction.checkInOutExit({
        "strQuery":
            "exec astil_mapps.dbo.sp_visitors_checking @opt = $opt, @vid = '$passId', @igateid = '${selectedCompany.value?.iCID}'",
        "strCon": "EMR_CONSTR",
      });
    }
    print("Check In - Out - Exit  : ${actionClicked.value}");
  }

  // Future<void> onClickExit(passId) async {
  //   actionClicked.value = await _apiFunction.checkInOutExit({
  //     "strQuery":
  //         "exec astil_mapps.dbo.sp_visitors_checking @opt = 4, @vid = '$passId', @igateid = '${selectedCompany.value?.iCID}'",
  //     "strCon": "EMR_CONSTR",
  //   });
  //
  //   print({
  //     "strQuery":
  //         "exec astil_mapps.dbo.sp_visitors_checking @opt = 4, @vid = '$passId', @igateid = '${selectedCompany.value?.iCID}'",
  //     "strCon": "EMR_CONSTR",
  //   });
  //
  //   print("CheckIn  : ${actionClicked.value}");
  // }

  fetchPassDetails(passId) async {
    final data = await _apiFunction.getPassDetailV2({
      "strQuery":
          "exec astil_mapps.dbo.sp_visitors_checking @opt = '10',@vid = '$passId'",
      "strCon": "EMR_CONSTR",
    });
    passDetailList.assignAll(data);
    print("Pass Details List : $passDetailList");
  }

  void getBack() {
    fetchVisitorReport(
      drawerController.optFlag,
      dateController.dateFlag,
      dateController.fromDate,
      dateController.toDate,
      "",
    );
    Get.back();
  }
}
