import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitor_pass_v2/config/app_colors.dart';
import 'package:visitor_pass_v2/routes/app_pages.dart';
import 'package:visitor_pass_v2/routes/app_routes.dart';
import 'package:visitor_pass_v2/screens/not_found_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'controllers/login_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    MobileScannerPlatform.instance.setBarcodeLibraryScriptUrl('zxing.min.js');
  }
  Get.put(LoginController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Visitor Pass',

      // Debugger Icon
      debugShowCheckedModeBanner: false,

      // App Theme
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
      ),

      // Router
      initialRoute: AppRoutes.home,
      getPages: AppPages.pages,

      unknownRoute: GetPage(
        name: AppRoutes.notFound,
        page: () => const NotFoundScreen(),
      ),
    );
  }
}
