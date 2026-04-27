import 'package:flutter/material.dart';
import 'package:visitor_pass_v2/config/app_colors.dart';
import 'package:visitor_pass_v2/controllers/scan_qr_controller.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:get/get.dart';
import 'package:visitor_pass_v2/models/company_model.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_toast.dart';

class ScanQrMobileScreen extends StatefulWidget {
  const ScanQrMobileScreen({super.key});

  @override
  State<ScanQrMobileScreen> createState() => _ScanQrMobileScreenState();
}

class _ScanQrMobileScreenState extends State<ScanQrMobileScreen>
    with TickerProviderStateMixin {
  bool _isScanned = false;
  bool _scannerReady = false;

  late AnimationController _controller;
  late Animation<double> _animation;
  MobileScannerController scannerController = MobileScannerController();
  final ScanQrController scanQrController = Get.put(ScanQrController());

  @override
  void initState() {
    super.initState();
    if (scanQrController.selectedCompany.value != null) {
      scanCall();
    }
  }

  scanCall() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Simulate scanner ready delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _scannerReady = true;
      });
    });
  }

  stopScan() {
    _controller.dispose();
    scannerController.dispose();
  }

  changeWard() async {
    // stopScan();
    _isScanned = false;

    await scannerController.stop();
    scanQrController.changeCompany();
  }

  @override
  void dispose() {
    _controller.dispose();
    scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scanArea = size.width * 0.7;

    return Obx(() {
      return scanQrController.selectedCompany.value == null
          ? Scaffold(
              body: Column(
                children: [
                  Text(
                    "Please select a ward first to continue.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SelectCompany(context, scanCall),
                ],
              ),
            )
          : Scaffold(
              // backgroundColor: Colors.white,
              appBar: CustomAppBar(
                title:
                    "${scanQrController.selectedCompany.value?.ccompanyname}",
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                leading: IconButton(
                  onPressed: () => changeWard(),
                  icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                ),
              ),
              body: _scannerReady
                  ? Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              SizedBox(height: 10),
                              MobileScanner(
                                controller: scannerController,
                                // allowDuplicates: false,
                                onDetect: (capture) async {
                                  if (_isScanned) return;

                                  final barcodes = capture.barcodes;
                                  if (barcodes.isEmpty) return;

                                  final String? qrText =
                                      barcodes.first.rawValue;

                                  await scanQrController.checkInAndroid(
                                    context,
                                    qrText,
                                  );
                                  await scannerController.stop();
                                  _isScanned = false;
                                  await Future.delayed(
                                    const Duration(seconds: 2),
                                  );

                                  await scannerController.start();
                                },
                              ),

                              // Scanning overlay
                              Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: scanArea,
                                      height: scanArea,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: AppColors.primary,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      child: AnimatedBuilder(
                                        animation: _animation,
                                        builder: (context, child) {
                                          return Transform.translate(
                                            offset: Offset(
                                              0,
                                              _animation.value * scanArea,
                                            ),
                                            child: child,
                                          );
                                        },
                                        child: Container(
                                          width: scanArea,
                                          height: 3,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.blue.withOpacity(0.0),
                                                Colors.blue.withOpacity(0.8),
                                                Colors.blue.withOpacity(0.0),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Positioned(
                              //   top: 50,
                              //   left: 20,
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       scanQrController.selectedWard.value=null;
                              //     },
                              //     child: Container(
                              //       decoration: BoxDecoration(
                              //         color: Colors.black.withOpacity(0.5),
                              //         shape: BoxShape.circle,
                              //       ),
                              //       padding: const EdgeInsets.all(8),
                              //       child: const Icon(
                              //         Icons.arrow_back,
                              //         color: Colors.white,
                              //         size: 28,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Positioned(
                                bottom: 60,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Text(
                                      "Place the QR code inside the frame\nThe scan will happen automatically",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
            );
    });
  }
}

Widget SelectCompany(BuildContext context, VoidCallback scanReady) {
  final ScanQrController scanQrController = Get.put(ScanQrController());

  onClickWardList(value) async {
    CustomToast.showLoading(context: context);
    scanQrController.selectedCompany.value = value;
    scanReady();
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
