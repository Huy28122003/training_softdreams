import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:training_softdreams/app/app_routes.dart';
import 'package:training_softdreams/configs/enums.dart';
import 'package:training_softdreams/di/locator.dart';
import 'package:training_softdreams/domain/usecases/user/login_use_case.dart';
import 'package:training_softdreams/domain/usecases/user/sign_up_use_case.dart';

class AuthController extends GetxController {
  RxBool isLoginMode = true.obs;
  RxString email = "".obs;
  RxString password = "".obs;
  RxString confirmPassword = "".obs;
  var status = LoadingStatus.initial.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final LoginUseCase loginUseCase = locator<LoginUseCase>();
  final SignUpUseCase signUpUseCase = locator<SignUpUseCase>();

  Future<void> onLogIn() async {
    status.value = LoadingStatus.loading;
    final email = this.email.value;
    final password = this.password.value;
    if (!GetUtils.isEmail(email) || password.trim().length < 8) {
      Get.snackbar("Syntax Error", "Invalid email(password) format");
      status.value = LoadingStatus.failure;
      return;
    }
    status.value = LoadingStatus.loading;

    final result = await loginUseCase
        .call(LoginArguments(email: email, password: password));

    result.fold(
      (error) {
        status.value = LoadingStatus.failure;
      },
      (success) {
        if (success.value1) {
          Get.offAllNamed(AppRoutes.home);
          status.value = LoadingStatus.success;
        } else {
          status.value = LoadingStatus.failure;
        }
        Get.snackbar("", success.value2);
      },
    );
  }

  void onChangeMode() {
    isLoginMode.value = !isLoginMode.value;
    email.value = "";
    password.value = "";
    confirmPassword.value = "";

    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  Future<void> onSignUp() async {
    status.value = LoadingStatus.loading;

    final email = this.email.value.trim();
    final password = this.password.value;
    final confirmPassword = this.confirmPassword.value;

    if (!GetUtils.isEmail(email) || password.length < 8) {
      Get.snackbar("Syntax Error", "Invalid email or password format");
      status.value = LoadingStatus.failure;
      return;
    } else if (confirmPassword != password) {
      Get.snackbar("Password Error", "Passwords do not match");
      status.value = LoadingStatus.failure;
      return;
    }

    final result = await signUpUseCase
        .call(SignUpArguments(email: email, password: password));

    result.fold(
      (error) {
        status.value = LoadingStatus.failure;
      },
      (success) {
        if (success.value1) {
          Get.offAllNamed(AppRoutes.home);
          status.value = LoadingStatus.success;
        } else {
          status.value = LoadingStatus.failure;
        }
        Get.snackbar("", success.value2);
      },
    );
  }
}
