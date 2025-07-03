import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ScreenType {
  smallMobile,
  mobile,
  desktop,
  tablet,
  watch,
}

Map<ScreenType, double> _defaultBreakpoints = {
  ScreenType.desktop: 950,
  ScreenType.tablet: 600,
  ScreenType.watch: 300,
  ScreenType.smallMobile: 375,
};

extension ResponsiveExt on BuildContext {
  MediaQueryData get data => MediaQuery.of(this);

  Size get screenSize => data.size;

  double get screenHeight => screenSize.height;

  double get screenWidth => screenSize.width;

  Orientation get orientation => data.orientation;

  ScreenType get screenType {
    final deviceWidth = kIsWeb ? screenSize.width : screenSize.shortestSide;

    if (deviceWidth >= _defaultBreakpoints[ScreenType.desktop]!) {
      return ScreenType.desktop;
    } else if (deviceWidth >= _defaultBreakpoints[ScreenType.tablet]!) {
      return ScreenType.tablet;
    } else if (deviceWidth < _defaultBreakpoints[ScreenType.watch]!) {
      return ScreenType.watch;
    } else if (deviceWidth <= _defaultBreakpoints[ScreenType.smallMobile]!) {
      return ScreenType.smallMobile;
    }

    return ScreenType.mobile;
  }

  bool get isSmallMobile => screenType == ScreenType.smallMobile;

  bool get isMobile => screenType == ScreenType.mobile;

  bool get isTablet => screenType == ScreenType.tablet;

  bool get isDesktop => screenType == ScreenType.desktop;

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isPortrait => orientation == Orientation.portrait;
}
