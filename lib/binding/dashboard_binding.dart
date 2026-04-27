import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/custom_drawer_controller.dart';
import '../controllers/date_controller.dart';
import '../controllers/visitors_data_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DateController>(() => DateController());

    Get.lazyPut<VisitorsDataController>(() => VisitorsDataController());

    Get.lazyPut<CustomDrawerController>(() => CustomDrawerController());
  }
}