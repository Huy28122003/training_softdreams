import 'dart:async';

import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../utils/constants/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() async {
      // await AppAssets.precacheAssets(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.045, 1],
                colors: [
                  Color(0xFF4093CE),
                  Color.fromRGBO(155, 206, 243, 0.9),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4.0),
                  blurRadius: 4.0,
                  color: Colors.black.withOpacity(0.25),
                ),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Assets.images.logo.svg(
                  width: 100,
                  height: 100,
                ),
                const Text(
                  appTitle,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
