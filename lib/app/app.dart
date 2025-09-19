import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'app_pages.dart';
import 'app_routes.dart';
import '../configs/themes/app_themes.dart';
import '../presentation/blocs/auth/auth_bloc.dart';
import '../utils/constants/strings.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isAuthenticated) {
              Get.offAllNamed(AppRoutes.auth);
            } else if (state.status.isUnauthenticated) {
              Get.offAllNamed(AppRoutes.auth);
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) =>
              previous.message != current.message,
          listener: (context, state) {
            if (state.message != null) {
              Fluttertoast.showToast(msg: state.message!);
            }
          },
        ),
      ],
      child: GetMaterialApp(
        title: appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        getPages: AppPages.routes,
        initialRoute: AppRoutes.splash,
      ),
    );
  }
}
