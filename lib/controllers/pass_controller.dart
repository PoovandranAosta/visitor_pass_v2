import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:visitor_pass_v2/models/pass_data_model.dart';
import 'package:visitor_pass_v2/models/pass_details_model.dart';
import 'package:visitor_pass_v2/routes/app_routes.dart';
import 'package:intl/intl.dart';
import '../config/encryption_helper.dart';
import '../services/api_function.dart';

class PassController extends GetxController {
  final passId = "0".obs;
  final passIdUrl = "0".obs;

  @override
  void onInit() {
    super.onInit();
    fetchPassId();
    getPassIdUrl();
    checkPass();
  }

  // Api Functions
  final ApiFunction _apiFunction = ApiFunction();

  RxList<PassDataModel> passDetailList = <PassDataModel>[].obs;

  // Loading
  final isLoadingPassDetail = false.obs;

  checkPass() {
    isLoadingPassDetail.value = true;

    if (passId.value.isNotEmpty && passId.value != '0') {
      fetchPassDetails(passId.value);
      print("Using passId: ${passId.value}");
    } else if (passIdUrl.value.isNotEmpty && passIdUrl.value != '0') {
      fetchPassDetails(passIdUrl.value);
      print("Using passIdUrl: ${passIdUrl.value}");
    } else {
      print("No valid Pass Id found");
    }

    isLoadingPassDetail.value = false;
  }

  String formatToDdMMMyy(String isoDate) {
    return DateFormat('dd MMM yy').format(DateTime.parse(isoDate));
  }

  fetchPassId() {
    try {
      final args = Get.arguments;
      passId.value = args['passId'];
      print(" Generated Pass Id : $passId");
    } catch (e) {
      print("Exception : $e");
    }
  }

  Future<void> getPassIdUrl() async {
    final uri = Uri.base;
    final fragment = uri.fragment;
    if (fragment.isEmpty) {
      if (kDebugMode) {
        print("No fragment found in URL");
      }
      return;
    }
    final fragmentUri = Uri.parse("http://dummy/$fragment");
    final passId = fragmentUri.queryParameters['passId'];
    if (passId != null && passId.isNotEmpty) {
      if (kDebugMode) {
        print("Pass ID from URL: $passId");
      }
      String decryptPassId =SecureEncryptionHelper.decrypt(passId);


      print("Decode Pass Id : $decryptPassId");

      passIdUrl.value = decryptPassId;
    } else {
      if (kDebugMode) {
        print("Invalid or Missing Pass ID");
      }
    }
  }

  fetchPassDetails(passId) async {
    final data = await _apiFunction.getPassDetailV2({
      "strQuery":
          "exec astil_mapps.dbo.sp_visitors_checking @opt = '10',@vid = '$passId'",
      "strCon": "EMR_CONSTR",
    });
    passDetailList.assignAll(data);
    print("Pass Details List : $passDetailList");
  }

  navigateQR() {
    Get.toNamed(AppRoutes.scanQr);
  }

  goBack() {
    Get.back();
  }
}
