import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:visitor_pass_v2/models/company_model.dart';
import '../config/config.dart';
import '../config/encryption_helper.dart';
import '../models/pass_details_model.dart';
import '../routes/app_routes.dart';
import '../services/api_function.dart';

class VisitorEntryController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    await fetchCompany();
  }

  final ApiFunction _apiFunction = ApiFunction();

  final TextEditingController visitorNameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController whomToMeetController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();

  String get visitorName => visitorNameController.text;

  String get companyName => companyNameController.text;

  String get mobileNo => mobileController.text;

  String get address => addressController.text;

  String get whomToMeet => whomToMeetController.text;

  String get purpose => purposeController.text;

  RxList<PassDetailsModel> passDetailList = <PassDetailsModel>[].obs;

  // Loading
  final isLoadingPatDetail = false.obs;

  final isLoading = false.obs;


  RxList<CompanyModel> companyList = <CompanyModel>[].obs;
  Rx<CompanyModel?> selectedCompany = Rx(null);


  RxBool isSubmitEnabled = false.obs;

  RxString passId = "".obs;

  Future<void> fetchCompany() async {
    final data = await _apiFunction.fetchCompanyList({
      "strQuery": "exec ASTIL_MApps.dbo.SP_tblvstrcompany_MAPPS @opt = 1",
      "strCon": "EMR_CONSTR",
    });
    companyList.assignAll(data);
    print("Company List : $companyList");
  }

  void validate() {
    isSubmitEnabled.value =
        visitorName.trim().isNotEmpty &&
        companyName.trim().isNotEmpty &&
        mobileNo.trim().isNotEmpty &&
        mobileNo.length == 10 &&
        address.trim().isNotEmpty &&
        whomToMeet.trim().isNotEmpty &&
        purpose.trim().isNotEmpty &&
        selectedCompany.value != null;

    print(isSubmitEnabled.value);
  }



  clear() {
    visitorNameController.clear();
    companyNameController.clear();
    mobileController.clear();
    addressController.clear();
    whomToMeetController.clear();
    purposeController.clear();

    selectedCompany.value = null;
    validate();
  }

  Future<void> whatsappMsg(passId) async {
    final encPassId =
    SecureEncryptionHelper.encrypt("$passId");
    await _apiFunction.whatsAppMsg({
      "strQuery":
      "exec astil_mapps.dbo.sp_visitorscan_mapps @mobno = '$mobileNo', @clink = '${Config
          .siteUrl}#/pass/?passId=$encPassId'",
      "strCon": "EMR_CONSTR",
    });
  }



  Future<String> submit() async {
    print("Submit Clicked");
    isLoading.value = true;
    print({
      "strQuery":
          "exec ASTIL_MApps.dbo.SP_tblvstrcompany_MAPPS @opt = 2,"
          " @cvstrname='$visitorName',"
          " @cvstrfrom='$companyName',"
          " @cvstraddr='$address',"
          " @cvstrphon='$mobileNo',"
          " @cvstrImageData='',"
          " @icid='${selectedCompany.value?.iCID}',"
          " @cwhom='$whomToMeet',"
          " @cpurpose='$purpose',"
          "@cdevicename=''",
      "strCon": "EMR_CONSTR",
    });

    final data = await _apiFunction.saveForm({
      "strQuery":
          "exec ASTIL_MApps.dbo.SP_tblvstrcompany_MAPPS @opt = 2,"
          " @cvstrname='$visitorName',"
          " @cvstrfrom='$companyName',"
          " @cvstraddr='$address',"
          " @cvstrphon='$mobileNo',"
          " @cvstrImageData='',"
          " @icid='${selectedCompany.value?.iCID}',"
          " @cwhom='$whomToMeet',"
          " @cpurpose='$purpose',"
          "@cdevicename=''",
      "strCon": "EMR_CONSTR",
    });

    print("Submit Response : $data");
    // passId.value = RegExp(r'\d+').firstMatch(data)!.group(0)!;
    // print("Pass Id : ${passId.value}");
    //
    // if (passId.value.isNotEmpty) {
    //   whatsappMsg(passId.value.toString());
    //   goBack();
    // }
    // return data;

    print("Submit Response : $data");

    final match = RegExp(r'\d+').firstMatch(data);

    if (match != null) {
      passId.value = match.group(0) ?? "";

      print("Pass Id : ${passId.value}");

      if (passId.value.isNotEmpty) {
        // await checkInOrOut(passId.value);
        whatsappMsg(passId.value);
      }
    } else {
      print("No Pass ID found in response.");
      // Handle Already Raised Case Here
    }
    isLoading.value = false;

    Get.offAllNamed(AppRoutes.pass, arguments: {'passId': passId.value});

    return data;
  }
}
