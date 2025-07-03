import 'dart:math';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class DemoPageRouteScreen extends StatefulWidget {
  const DemoPageRouteScreen({super.key});

  @override
  State<DemoPageRouteScreen> createState() => _DemoPageRouteScreenState();
}

class _DemoPageRouteScreenState extends State<DemoPageRouteScreen> {
  late final Color _backgroundColor;
  PageTransitionType _animationType = PageTransitionType.fade;

  @override
  void initState() {
    super.initState();
    final random = Random();
    _backgroundColor = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<PageTransitionType>(
              value: _animationType,
              items: PageTransitionType.values
                  .map<DropdownMenuItem<PageTransitionType>>(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _animationType = value ?? PageTransitionType.fade;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: _animationType,
                    alignment: Alignment.center,
                    child: const DemoPageRouteScreen(),
                    childCurrent: widget,
                  ),
                );
              },
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
