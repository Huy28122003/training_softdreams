import 'package:get/get.dart';
import 'package:training_softdreams/presentation/pages/auth/controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
