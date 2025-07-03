import 'package:flutter/material.dart';

import '../../../utils/mixin/network_aware_state_mixin.dart';

class DemoConnectivityScreen extends StatefulWidget {
  const DemoConnectivityScreen({super.key});

  @override
  State<DemoConnectivityScreen> createState() => _DemoConnectivityScreenState();
}

class _DemoConnectivityScreenState extends State<DemoConnectivityScreen>
    with NetworkAwareStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          isDisconnected ? 'No network connection' : 'Network connected',
        ),
      ),
    );
  }

  @override
  void onDisconnected() {
    print('onDisconnected');
    setState(() {});
  }

  @override
  void onReconnected() {
    print('onReconnected');
    setState(() {});
  }
}
