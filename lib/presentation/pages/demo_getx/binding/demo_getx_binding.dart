import 'package:get/get.dart';

import '../controller/demo_getx_controller.dart';

class DemoGetXBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DemoGetXController>(() => DemoGetXController());
  }
}
