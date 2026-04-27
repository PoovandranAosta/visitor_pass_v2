import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:visitor_pass_v2/controllers/pass_controller.dart';
import '../config/app_colors.dart';
import '../widgets/custom_pass_card.dart';

class PassScreen extends StatelessWidget {
  const PassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PassController passController = Get.put(PassController());
    return Scaffold(
      body: Obx(() {
        final id = passController.passId.value;
        final url = passController.passIdUrl.value;

        // Check if data is loading
        if (passController.isLoadingPassDetail.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        // Check if passDetailList has data
        if (passController.passDetailList.isEmpty) {
          return const Center(
            child: Text(
              "Your Pass details have been sent to your WhatsApp number. Please check your messages.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        // Safely get the first item
        final detail = passController.passDetailList[0];

        if (id != "0" || url != "0") {
          return Center(
            child: VisitorInfoCard(
              qrData: id != "0" ? id : url,
              visitorName: detail.vName ?? "",
              visitorCompany: "${detail.vFrom ?? ""}",
              company: detail.toCompanyName!,
              toMeet: detail.toWhom ?? " - ",
              purpose: detail.toPurpose ?? "",
              accentColor: AppColors.primary,
            ),
          );
        }

        return const Center(
          child: Text(
            "Your Pass details have been sent to your WhatsApp number. Please check your messages.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }),
    );
  }
}
