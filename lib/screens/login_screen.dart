import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_pass_v2/config/app_colors.dart';
import 'package:visitor_pass_v2/controllers/login_controller.dart';
import '../widgets/custom_alert_dialog.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_login.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        title: "Visitor Pass",
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

      ),

      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Obx(() {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CustomLogin(
                          usernameController:
                              loginController.usernameController,
                          passwordController:
                              loginController.passwordController,
                          isLoading: loginController.isLoading.value,
                          onLogin: (username, password) async {
                            bool login = await loginController
                                .loginStepComplete();
                            if (login) {
                              loginController.navigateControlDashBoard();
                              loginController.clearLogin();
                            } else {
                              CustomAlertDialog.show(
                                context,
                                title: "Login Failed",
                                message:
                                    "Please check your username and password and try again.",
                                icon: Icons.error_outline,
                                iconBgColor: AppColors.error,
                                // or Colors.red
                                primaryText: "Try Again",
                                onPrimaryTap: () {
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          },
                          primaryColor: AppColors.primary,
                          buttonColor: AppColors.primary,
                          title: "Login",
                        ),

                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
