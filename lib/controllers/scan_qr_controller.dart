import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:visitor_pass_v2/controllers/visitors_data_controller.dart';
import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../models/company_model.dart';
import '../models/pass_data_model.dart';
import '../services/api_function.dart';
import '../services/common_functions.dart';
import '../services/print_services.dart';
import '../widgets/custom_toast.dart';

class ScanQrController extends GetxController {
  // Api Functions
  final ApiFunction _apiFunction = ApiFunction();

  RxList<CompanyModel> companyList = <CompanyModel>[].obs;
  Rx<CompanyModel?> selectedCompany = Rx(null);

  final VisitorsDataController visitorsDataController = Get.put(
    VisitorsDataController(),
  );

  Future<void> fetchCompany() async {
    final data = await _apiFunction.fetchCompanyList({
      "strQuery": "exec ASTIL_MApps.dbo.SP_tblvstrcompany_MAPPS @opt = 1",
      "strCon": "EMR_CONSTR",
    });
    companyList.assignAll(data);
    print("Company List : $companyList");
  }

  changeCompany() {
    print("Change Company");
    selectedCompany.value = null;
  }

  Future<void> scanCode(BuildContext context, passId) async {
    print("PassId : $passId");
    // Check In The Pass First
    await checkIn(context, passId);
  }

  checkInAndroid(BuildContext context,passId) async {
    try {
      await visitorsDataController.onClickCheckInOut('2', passId);

      if (visitorsDataController.actionClicked.value != "[]") {
        print(visitorsDataController.actionClicked.value);
        CustomToast.show(
          context: context,
          message: "CheckIn Successfully",
          icon: Icons.check,
          backgroundColor: AppColors.success,
          iconColor: AppColors.scaffoldBackground,
        );
      } else {
        CustomToast.show(
          context: context,
          message: "CheckIn Failed",
          icon: Icons.close_rounded,
          backgroundColor: AppColors.error,
          iconColor: AppColors.scaffoldBackground,
        );
      }
    } catch (e) {
      CustomToast.show(
        context: context,
        message: "Something Went Wrong Try Again Later...",
        icon: Icons.warning_amber_rounded,
        backgroundColor: AppColors.warning,
        iconColor: AppColors.scaffoldBackground,
      );
    }
  }

  Future<void> checkIn(BuildContext context, passId) async {
    try {
      await visitorsDataController.onClickCheckInOut('2', passId);

      if (visitorsDataController.actionClicked.value != "[]") {
        print(visitorsDataController.actionClicked.value);
        CustomToast.show(
          context: context,
          message: "CheckIn Successfully",
          icon: Icons.check,
          backgroundColor: AppColors.success,
          iconColor: AppColors.scaffoldBackground,
        );
        getPassDetails(context, passId);
      } else {
        CustomToast.show(
          context: context,
          message: "CheckIn Failed",
          icon: Icons.close_rounded,
          backgroundColor: AppColors.error,
          iconColor: AppColors.scaffoldBackground,
        );
      }
    } catch (e) {
      CustomToast.show(
        context: context,
        message: "Something Went Wrong Try Again Later...",
        icon: Icons.warning_amber_rounded,
        backgroundColor: AppColors.warning,
        iconColor: AppColors.scaffoldBackground,
      );
    }
  }

  Future<void> getPassDetails(BuildContext context, passId) async {
    try {
      // Fetch The Pass Data
      await visitorsDataController.fetchPassDetails(passId);
      if (visitorsDataController.passDetailList.isNotEmpty) {
        CustomToast.show(
          context: context,
          message:
              "Visitor Name : ${visitorsDataController.passDetailList[0].vName}",
          icon: Icons.person,
          backgroundColor: AppColors.primary,
          iconColor: AppColors.scaffoldBackground,
        );
        // Print the Pass
        await printPass(visitorsDataController.passDetailList[0]);
      } else {
        CustomToast.show(
          context: context,
          message: "Invalid Visitor Pass",
          icon: Icons.close_rounded,
          backgroundColor: AppColors.error,
          iconColor: AppColors.scaffoldBackground,
        );
        print("Pass Detail Is Empty");
      }
      print(visitorsDataController.passDetailList);
    } catch (e) {
      CustomToast.show(
        context: context,
        message: "Something Went Wrong Try Again Later...",
        icon: Icons.warning_amber_rounded,
        backgroundColor: AppColors.warning,
        iconColor: AppColors.scaffoldBackground,
      );
    }
  }

  Future<void> printPass(PassDataModel pass) async {
    if (kIsWeb) {
      print("Web App Print");
      visitorPassView(
        company: pass.toCompanyName!,
        passId: pass.vID.toString(),
        name: pass.vName!,
        vCompany: pass.vFrom!,
        smartAddress: pass.vAddress!,
        mobile: pass.vMobile!,
        toMeet: pass.toWhom!,
        smartCheckIn: pass.vCheckIn!,
      );
      return;
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      print("Android App");
      // visitorPassView(
      //   company: pass.toCompanyName!,
      //   passId: pass.vID.toString(),
      //   name: pass.vName!,
      //   vCompany: pass.vFrom!,
      //   smartAddress: pass.vAddress!,
      //   mobile: pass.vMobile!,
      //   toMeet: pass.toWhom!,
      //   smartCheckIn: pass.vCheckIn!,
      // );
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      print("Windows App");
      passDataZpl(
        company: pass.toCompanyName!,
        passId: pass.vID.toString(),
        name: pass.vName!,
        vCompany: pass.vFrom!,
        address: pass.vAddress!,
        mobile: pass.vMobile!,
        toMeet: pass.toWhom!,
        checkIn: pass.vCheckIn!,
      );
    } else {
      print("Unsupported Format");
    }
  }
}
