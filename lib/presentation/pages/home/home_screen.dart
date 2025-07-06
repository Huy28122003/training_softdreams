import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_softdreams/app/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.demoBloc, arguments: 2);
                },
                child: const Text('Bloc'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.demoCubit);
                },
                child: const Text('Cubit'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.demoGetX);
                },
                child: const Text('GetX'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.demoProvider);
                },
                child: const Text('Provider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
