import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static final ToastUtils _instance = ToastUtils._();

  factory ToastUtils() => _instance;

  ToastUtils._() : _fToast = FToast();

  final FToast _fToast;

  void show(BuildContext context, String text) {
    _fToast.init(context);
    _fToast.showToast(
      toastDuration: const Duration(milliseconds: 1000),
      child: Material(
        color: const Color(0xFF27272A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 9.5,
            horizontal: 8.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.info,
                color: Colors.white,
              ),
              const SizedBox(width: 10.0),
              Flexible(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      gravity: ToastGravity.BOTTOM,
    );
  }
}
