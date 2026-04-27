import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:visitor_pass_v2/models/login_model.dart';
import 'package:visitor_pass_v2/models/login_user_model.dart';
import 'package:visitor_pass_v2/routes/app_routes.dart';

import '../services/api_function.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Api Functions
  final ApiFunction _apiFunction = ApiFunction();

  // Store Value
  RxList<LoginModel> loginModel = <LoginModel>[].obs;
  RxList<LoginUserModel> loginUserModel = <LoginUserModel>[].obs;

  RxBool isLoading = false.obs;


  RxString bearerToken = "".obs;

  String get userName => usernameController.text;

  String get pass => passwordController.text;

  RxString userId = "".obs;
  RxString userRole = "".obs;

  Future<void> login() async {
    final data = await _apiFunction.login({
      "UsrName": userName,
      "UsrPwd": pass,
      "LogOpt": "2",
    });
    print(data);
    loginModel.assignAll(data);
    print("Login : ${loginModel.first.status}");
  }

  Future<String> loginKmch() async {
    final data = await _apiFunction.loginKmch({
      "UsrName": userName,
      "UsrPwd": pass,
      "LogOpt": "2",
    });
    print(data);
    return data;
  }


  Future<void> getUserId() async {
    userId.value = await _apiFunction.getUserId({
      "strQuery":
          "exec ASTIL_MApps.dbo.sp_vstuserscheck @opt = 2,@cusername ='$userName'",
      "strCon": "EMR_CONSTR",
    });
    print("User Id : $userId");
  }

  Future<void> getUserRole() async {
    userRole.value = await _apiFunction.getUserRole({
      "strQuery":
          "exec ASTIL_MApps.dbo.sp_vstuserscheck @opt = 1,@iuserid =$userId",
      "strCon": "EMR_CONSTR",
    });

    print("User Role : ${userRole.value}");
  }

  Future<bool> loginStepComplete() async {
    isLoading.value =true;
    await login();
    // String status = await loginKmch();
    if (loginModel.first.status == '1') {
      await getUserId();
      await getUserRole();
      print("${userRole.value}");
      print("${userRole.value == 'Security'}");
      print("${userRole.value == 'Staff'}");
      isLoading.value =false;
      return true;
    } else {
      print(" Login Is Denied Because Status is Not 1");
      isLoading.value =false;
      return false;
    }

  }

  clearLogin(){
    usernameController.text="";
    passwordController.text="";
  }

  navigateControlDashBoard() {
    Get.offAllNamed(AppRoutes.dashboard);
  }
}
