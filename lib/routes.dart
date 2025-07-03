import 'package:flutter/material.dart';

import 'presentation/screens/screens.dart';

enum Routes {
  splash,
  intro,
  home,
}

extension GetRouteName on Routes {
  String get routeName => _Paths.of(this);
}

class _Paths {
  static const String splash = '/';
  static const String intro = '/intro';
  static const String home = '/home';

  static const Map<Routes, String> _pathMap = {
    Routes.splash: _Paths.splash,
    Routes.intro: _Paths.intro,
    Routes.home: _Paths.home,
  };

  static String of(Routes route) => _pathMap[route]!;
}

class AppNavigator {
  AppNavigator._();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case _Paths.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  }

  static bool _isCurrent(Routes route) {
    final String routeName = _Paths.of(route);
    bool isCurrent = false;
    state?.popUntil((r) {
      if (r.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }

  static Future<T?>? push<T>(Routes route, [Object? arguments]) =>
      state?.pushNamed<T>(_Paths.of(route), arguments: arguments);

  static Future<T?>? pushIfNotCurrent<T>(Routes route, [Object? arguments]) {
    if (!_isCurrent(route)) {
      return push<T>(route, arguments);
    }
    return Future.value();
  }

  static Future<T?>? replaceWith<T, TO>(
    Routes route, {
    TO? result,
    Object? arguments,
  }) {
    return state?.pushReplacementNamed<T, TO>(
      _Paths.of(route),
      result: result,
      arguments: arguments,
    );
  }

  static Future<T?>? replaceToFirst<T>(
    Routes route, {
    Object? arguments,
  }) {
    return state?.pushNamedAndRemoveUntil<T>(
      _Paths.of(route),
      (route) => false,
      arguments: arguments,
    );
  }

  static void pop<T>([T? result]) => state?.pop<T>(result);

  static void popToFirst() => state?.popUntil((route) => route.isFirst);

  static void popCount(int count) => state?.popUntil((_) => count-- <= 0);

  static Future<bool>? maybePop<T>([T? result]) => state?.maybePop<T>(result);

  static NavigatorState? get state => navigatorKey.currentState;
}
