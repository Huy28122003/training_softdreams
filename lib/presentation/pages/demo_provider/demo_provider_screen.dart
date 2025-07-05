import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'service/demo_provider_service.dart';

class DemoProviderScreen extends StatefulWidget {
  const DemoProviderScreen({super.key});

  @override
  State<DemoProviderScreen> createState() => _DemoProviderScreenState();
}

class _DemoProviderScreenState extends State<DemoProviderScreen> {
  late final DemoProviderService _providerService;

  @override
  void initState() {
    _providerService = context.read<DemoProviderService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Provider"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          Consumer<DemoProviderService>(
            builder: (context, provider, child) {
              return SizedBox(
                width: 50,
                height: 100,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedContainer(
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _getColor(provider.volume),
                    ),
                    duration: const Duration(milliseconds: 300),
                    width: 50,
                    height: provider.volume * 10.0,
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              _providerService.increase();
            },
            child: Text("Increase"),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              _providerService.decrease();
            },
            child: Text("Decrease"),
          ),
        ],
      ),
    );
  }

  Color _getColor(int value) {
    return value > 7
        ? Colors.green
        : value > 3
            ? Colors.yellow
            : Colors.red;
  }
}
