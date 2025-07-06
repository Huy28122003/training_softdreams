import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Tuple2<bool, String>> login(
    String email,
    String password,
  ) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return Tuple2(true, "Login Success");
    } on FirebaseAuthException catch (e) {
      String message = "";
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
      return Tuple2(false, message);
    } catch (e) {
      return Tuple2(false, "Something went wrong");
    }
  }

  Future<Tuple2<bool, String>> signUp(
    String email,
    String password,
  ) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Tuple2(true, "SignUp Success");
    } on FirebaseAuthException catch (e) {
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
      return Tuple2(false, message);
    } catch (e) {
      return Tuple2(false, e.toString());
    }
  }
}
