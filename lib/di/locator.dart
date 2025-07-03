import 'package:get_it/get_it.dart';

import 'module/module.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  await LocalModule.registerModule();
  NetworkModule.registerModule();
  AppModule.registerModule();
}
