import 'package:flutter/material.dart';

import '../../utils/extensions/responsive_ext.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.watch,
  }) : super(key: key);

  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;
  final WidgetBuilder? watch;

  @override
  Widget build(BuildContext context) {
    final screenType = context.screenType;

    if (screenType == ScreenType.desktop) {
      if (desktop != null) return desktop!(context);
      if (tablet != null) return tablet!(context);
    }

    if (screenType == ScreenType.tablet) {
      if (tablet != null) return tablet!(context);
    }

    if (screenType == ScreenType.watch) {
      if (watch != null) return watch!(context);
    }

    return mobile(context);
  }
}
