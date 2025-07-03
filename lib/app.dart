import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'configs/themes/app_themes.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/screens/splash/splash_screen.dart';
import 'routes.dart';
import 'utils/constants/strings.dart';

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
              AppNavigator.replaceToFirst(Routes.home);
            } else if (state.status.isUnauthenticated) {
              AppNavigator.replaceToFirst(Routes.intro);
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
      child: MaterialApp(
        title: appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        navigatorKey: AppNavigator.navigatorKey,
        onGenerateRoute: AppNavigator.onGenerateRoute,
        home: const SplashScreen(),
      ),
    );
  }
}
