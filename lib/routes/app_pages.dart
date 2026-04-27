import 'package:get/get.dart';
import '../binding/dashboard_binding.dart';
import '../screens/visitor_screen.dart';
import '../screens/control_dashboard_screen.dart';
import '../screens/login_screen.dart';
import '../screens/not_found_screen.dart';
import '../screens/pass_screen.dart';
import '../screens/scan_qrcode_mobile_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.home, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(
      name: AppRoutes.dashboard,
      binding: DashboardBinding(),
      page: () => const ControlDashboardScreen(),
    ),
    GetPage(name: AppRoutes.pass, page: () => const PassScreen()),
    // GetPage(name: AppRoutes.scanQr, page: () => const ScanQrScreen()),
    GetPage(name: AppRoutes.visitor, page: () => const VisitorScreen()),
    GetPage(name: AppRoutes.notFound, page: () => const NotFoundScreen()),
  ];
}
