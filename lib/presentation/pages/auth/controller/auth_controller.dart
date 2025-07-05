import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:training_softdreams/configs/enums.dart';

class AuthController extends GetxController {
  RxBool isLoginMode = true.obs;
  RxString email = "".obs;
  RxString password = "".obs;
  RxString confirmPassword = "".obs;
  var status = LoadingStatus.initial.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> onLogIn() async {
    status.value = LoadingStatus.loading;
    final email = this.email.value;
    final password = this.password.value;
    if (!GetUtils.isEmail(email) || password.trim().length < 8) {
      Get.snackbar("Syntax Error", "Invalid email(password) format");
      status.value = LoadingStatus.failure;
      return;
    }
    try {
      status.value = LoadingStatus.loading;

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      status.value = LoadingStatus.success;
    } on FirebaseAuthException catch (e) {
      status.value = LoadingStatus.failure;

      String message;
      print(e.code);
      switch (e.code) {
        case 'invalid-credential':
          message = "Invalid account";
          break;
        case 'wrong-password':
          message = "Incorrect password.";
          break;
        case 'user-disabled':
          message = "This account has been disabled.";
          break;
        default:
          message = "Login failed. Please try again.";
      }

      Get.snackbar("Login Error", message);
    } catch (e) {
      status.value = LoadingStatus.failure;
      Get.snackbar("Error", "An unexpected error occurred.");
    }
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

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      status.value = LoadingStatus.success;
      Get.snackbar("Success", "Account created successfully");
    } on FirebaseAuthException catch (e) {
      status.value = LoadingStatus.failure;

      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = "This email is already registered.";
          break;
        case 'invalid-email':
          message = "Invalid email format.";
          break;
        case 'weak-password':
          message = "Password is too weak.";
          break;
        default:
          message = "Sign up failed. Please try again.";
      }

      Get.snackbar("Sign Up Error", message);
    } catch (e) {
      status.value = LoadingStatus.failure;
      Get.snackbar("Error", "An unexpected error occurred.");
    }
  }
}
