import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:visitor_pass_v2/models/company_model.dart';
import '../config/app_colors.dart';
import '../controllers/scan_qr_controller.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_scan_indicator.dart';
import '../widgets/custom_toast.dart';


class ScanQrDesktopScreen extends StatefulWidget {
  const ScanQrDesktopScreen({super.key});

  @override
  State<ScanQrDesktopScreen> createState() => _ScanQrDesktopScreenState();
}

class _ScanQrDesktopScreenState extends State<ScanQrDesktopScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final ScanQrController scanQrController = Get.put(ScanQrController());

  bool isFocused = false;

  @override
  void initState() {
    super.initState();

    /// Listen for focus changes
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });

    /// Always keep focus ready for scanner
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
  }

  Future<void> _onSubmitted(String value) async {
    String scannedValue = value.trim();

    if (scannedValue.isEmpty) return;

    print("Scan Function _onSubmitted");

    await scanQrController.scanCode(context, scannedValue);

    controller.clear();

    /// Ready for next scan
    Future.delayed(const Duration(seconds: 2), () {
      focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return scanQrController.selectedCompany.value == null
          ? Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Text(
                    "Please select a company first to continue.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SelectCompany(context),
                ],
              ),
            )
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: CustomAppBar(
                title:
                    "${scanQrController.selectedCompany.value?.ccompanyname}",
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                leading: IconButton(
                  onPressed: () => scanQrController.changeCompany(),
                  icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                ),
                actions: [
                  StatusIndicator(
                    isActive: isFocused,
                    activeText: "Scanning",
                    inactiveText: "Not Ready",
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(focusNode);
                    },
                    tooltip: "Refresh",
                    icon: Icon(Icons.refresh, color: Colors.white),
                  ),
                ],
              ),
              body: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/scanner.png',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 0,
                    width: 0,
                    child: Opacity(
                      opacity: 0,
                      child: TextField(
                        controller: controller,
                        focusNode: focusNode,
                        autofocus: true,
                        onSubmitted: _onSubmitted,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }
}

Widget SelectCompany(BuildContext context) {
  final ScanQrController scanQrController = Get.put(ScanQrController());

  onClickWardList(value) async {
    CustomToast.showLoading(context: context);
    scanQrController.selectedCompany.value = value;
    CustomToast.hideLoading();
    print(
      "Selected Company : ${scanQrController.selectedCompany.value?.ccompanyname}",
    );
  }

  return Obx(() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CommonDropdown<CompanyModel>(
        items: scanQrController.companyList,
        selectedValue:
            scanQrController.companyList.contains(
              scanQrController.selectedCompany.value,
            )
            ? scanQrController.selectedCompany.value
            : null,
        labelText: 'Company',
        itemLabel: (CompanyModel item) => item.ccompanyname.toString(),
        onChanged: (value) => onClickWardList(value),
      ),
    );
  });
}


