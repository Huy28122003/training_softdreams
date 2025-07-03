import 'package:flutter/material.dart';

extension ScrollControllerExt on ScrollController {
  void onScrollEndListener(
    final VoidCallback callback, {
    double offset = 0,
  }) {
    addListener(() {
      if (!hasClients) return;

      final maxScroll = position.maxScrollExtent;
      final currentScroll = position.pixels - offset;

      if (currentScroll == maxScroll) {
        callback();
      }
    });
  }
}
