import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_softdreams/app/app_routes.dart';
import 'package:training_softdreams/configs/enums.dart';

import '../controller/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: Text(
              controller.isLoginMode.value ? "Login" : "Sign Up",
              key: ValueKey(
                  controller.isLoginMode.value ? "LoginKey" : "SignUpKey"),
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  TextField(
                    onChanged: (value) => controller.email.value = value,
                    decoration: InputDecoration(labelText: "Email"),
                    controller: controller.emailController,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    onChanged: (value) => controller.password.value = value,
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Password"),
                    controller: controller.passwordController,
                  ),
                  Obx(
                    () {
                      return AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        child: (controller.isLoginMode.value)
                            ? SizedBox()
                            : Column(
                                children: [
                                  const SizedBox(height: 16),
                                  TextField(
                                    onChanged: (value) => controller
                                        .confirmPassword.value = value,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: "Confirm Password",
                                    ),
                                    controller:
                                        controller.confirmPasswordController,
                                  ),
                                ],
                              ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      Get.toNamed(AppRoutes.home);
                      return;
                      if (controller.isLoginMode.value) {
                        await controller.onLogIn();
                      } else {
                        await controller.onSignUp();
                      }
                    },
                    child: Obx(
                      () => (controller.isLoginMode.value)
                          ? Text("Login")
                          : Text("Sign Up"),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      controller.onChangeMode();
                    },
                    child: Obx(
                      () => (!controller.isLoginMode.value)
                          ? Text("Login")
                          : Text("Sign Up"),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () {
                if (controller.status.value == LoadingStatus.loading) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white.withAlpha(100),
                    child: Center(child: CupertinoActivityIndicator()),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
