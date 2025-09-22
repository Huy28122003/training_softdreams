import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_softdreams/app/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _openWeb() async {
    final Uri url = Uri.parse("https://flutter.dev");
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Không mở được $url');
    }
  }

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
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.animal);
                },
                child: const Text('Animal'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.chatBot);
                },
                child: const Text('Chat Bot'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.chart);
                },
                child: const Text('Chart'),
              ),
              ElevatedButton(
                onPressed: () {
                  _openWeb();
                },
                child: const Text('Open Flutter Website'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.speechToText);
                },
                child: const Text('Speech to Text'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.call);
                },
                child: const Text('Call'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.agentSip);
                },
                child: const Text('Agent'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
