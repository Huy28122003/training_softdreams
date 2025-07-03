import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';

mixin NetworkAwareStateMixin<T extends StatefulWidget> on State<T> {
  bool isDisconnected = false;
  late StreamSubscription<List<ConnectivityResult>> _networkSubscription;
  final Connectivity _connectivity = Connectivity();

  void onReconnected();

  void onDisconnected();

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    bool hasInternet = results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi);

    if (hasInternet) {
      if (isDisconnected) {
        isDisconnected = false;
        onReconnected();
      }
    } else {
      isDisconnected = true;
      onDisconnected();
    }
  }

  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    _networkSubscription = _connectivity.onConnectivityChanged.listen((result) {
      _updateConnectionStatus(result);
    });
  }

  @override
  void dispose() {
    _networkSubscription.cancel();
    super.dispose();
  }
}
