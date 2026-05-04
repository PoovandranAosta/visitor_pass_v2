import 'package:visitor_pass_v2/config/config.dart';
import 'package:visitor_pass_v2/models/check_in_out_model.dart';
import 'package:visitor_pass_v2/models/company_model.dart';
import 'package:visitor_pass_v2/models/gate_model.dart';
import 'package:visitor_pass_v2/models/login_model.dart';
import 'package:visitor_pass_v2/models/login_user_model.dart';
import 'package:visitor_pass_v2/models/pass_data_model.dart';
import 'package:visitor_pass_v2/models/pass_details_model.dart';
import 'package:visitor_pass_v2/models/summary_report_model.dart';
import 'package:visitor_pass_v2/models/visitors_data_model.dart';


import 'api_service.dart';

class ApiFunction {
  // Api Service
  final ApiService _service = ApiService();

  // Login API

  Future<List<LoginModel>> login(Map<String, dynamic> body) {
    return _service.apiCallNotList<LoginModel>(
      url: "/wsLogin.asmx/chkLoginNew",
      body: body,
      fromJson: (json) => LoginModel.fromJson(json),
    );
  }

  Future<String> loginKmch(Map<String, dynamic> body) {
    return _service.apiCallString(
      url: "/wsLogin.asmx/chkLoginNew",
      body: body,
    );
  }


  Future<String> getUserId(Map<String, dynamic> body) {
    return _service.apiCallString(
      url: "/EMRIndia/wsEMR.asmx/Getdataset1",
      body: body,
    );
  }

  Future<String> getUserRole(Map<String, dynamic> body) {
    return _service.apiCallString(
      url: "/EMRIndia/wsEMR.asmx/Getdataset1",
      body: body,
    );
  }



  Future<String?> GetToken() {
    return _service.getToken(
      url: "${Config.baseUrl2}/Appointment_FOAPI/Api/Gettoken",
    );
  }

  Future<List<LoginUserModel>> loginUserDetails(
    Map<String, dynamic> body,
    String token,
  ) {
    return _service.apiCallWithToken<LoginUserModel>(
      url: "${Config.baseUrl2}/Appointment_FOAPI/Api/GetJson",
      body: body,
      fromJson: (json) => LoginUserModel.fromJson(json),
      token: token,
    );
  }




  // V2

  Future<List<VisitorsDataModel>> fetchReport(Map<String, dynamic> body) {
    return _service.apiCall<VisitorsDataModel>(
      url: "/EMRIndia/wsEMR.asmx/Getdataset1",
      body: body,
      fromJson: (json) => VisitorsDataModel.fromJson(json),
    );
  }

  Future<String> onClickActions(Map<String, dynamic> body) {
    return _service.apiCallString(
      url: "/EMRIndia/wsEMR.asmx/Getdataset1",
      body: body,
    );
  }

  Future<List<CompanyModel>> fetchCompanyList(
      Map<String, dynamic> body,
      ) {
    return _service.apiCall<CompanyModel>(
      url: "/EMRIndia/wsEMR.asmx/Getdataset1",
      body: body,
      fromJson: (json) => CompanyModel.fromJson(json),
    );
  }

  Future<String> saveForm(Map<String, dynamic> body) {
    return _service.apiCallString(
      url: "/EMRIndia/wsEMR.asmx/Getdataset1",
      body: body,
    );
  }

  Future<String> checkInOutExit(Map<String, dynamic> body) {
    return _service.apiCallString(
      url: "/EMRIndia/wsEMR.asmx/Getdataset1",
      body: body,
    );
  }


  Future<List<PassDataModel>> getPassDetailV2(Map<String, dynamic> body) {
    return _service.apiCall<PassDataModel>(
      url: "/EMRIndia/wsEMR.asmx/Getdataset1",
      body: body,
      fromJson: (json) => PassDataModel.fromJson(json),
    );
  }

  Future<List<SummaryReportModel>> fetchSummrayReportModel(Map<String, dynamic> body) {
    return _service.apiCall<SummaryReportModel>(
      url: "/EMRIndia/wsEMR.asmx/Getdataset1",
      body: body,
      fromJson: (json) => SummaryReportModel.fromJson(json),
    );
  }

  Future<List<GateModel>> fetchGate(Map<String, dynamic> body) {
    return _service.apiCall<GateModel>(
      url: "/EMRIndia/wsEMR.asmx/Getdataset1",
      body: body,
      fromJson: (json) => GateModel.fromJson(json),
    );
  }


  Future<String> whatsAppMsg(Map<String, dynamic> body) {
    return _service.apiCallString(
      url: "/EMRIndia/wsEMR.asmx/Getdataset1",
      body: body,
    );
  }





}


