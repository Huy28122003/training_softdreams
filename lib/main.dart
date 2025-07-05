import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'app.dart';
import 'app_bloc_observer.dart';
import 'di/locator.dart';
import 'domain/usecases/auth/delete_token.dart';
import 'domain/usecases/auth/get_authorized_user.dart';
import 'firebase_options.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'utils/logging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = AppBlocObserver();
  await setupLocator();

  _registerErrorHandlers();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            getAuthorizedUser: locator<GetAuthorizedUser>(),
            deleteToken: locator<DeleteToken>(),
          )..onStart(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

void _registerErrorHandlers() {
  final Logger logger = Logging.createLogger('ErrorHandler');

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    logger.severe(details.toString());
    logger.severe(details.stack);
  };

  PlatformDispatcher.instance.onError =
      (Object exception, StackTrace stackTrace) {
    logger.severe(exception.toString());
    logger.severe(stackTrace);
    return true;
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('An Error Occurred'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Text(details.toString()),
        ),
      ),
    );
  };
}
