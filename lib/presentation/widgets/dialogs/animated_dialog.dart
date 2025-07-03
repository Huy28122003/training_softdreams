import 'package:flutter/material.dart';

enum DialogTransitionType {
  fade,
  slideFromTop,
  slideFromTopFade,
  slideFromBottom,
  slideFromBottomFade,
  slideFromLeft,
  slideFromLeftFade,
  slideFromRight,
  slideFromRightFade,
  scale,
  fadeScale,
  rotate,
  scaleRotate,
  fadeRotate,
  size,
  sizeFade,
  none,
}

Future<T?> showAnimatedDialog<T>({
  required BuildContext context,
  bool barrierDismissible = true,
  Color barrierColor = Colors.black54,
  required WidgetBuilder builder,
  DialogTransitionType animationType = DialogTransitionType.fade,
  Curve curve = Curves.linear,
  Duration duration = const Duration(milliseconds: 150),
  Alignment alignment = Alignment.center,
  Axis axis = Axis.vertical,
}) {
  return showGeneralDialog<T>(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return builder(context);
    },
    barrierColor: barrierColor,
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    transitionDuration: duration,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      switch (animationType) {
        case DialogTransitionType.fade:
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        case DialogTransitionType.slideFromTop:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: child,
          );
        case DialogTransitionType.slideFromTopFade:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        case DialogTransitionType.slideFromBottom:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: child,
          );
        case DialogTransitionType.slideFromBottomFade:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        case DialogTransitionType.slideFromLeft:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: child,
          );
        case DialogTransitionType.slideFromLeftFade:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        case DialogTransitionType.slideFromRight:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: child,
          );
        case DialogTransitionType.slideFromRightFade:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        case DialogTransitionType.scale:
          return ScaleTransition(
            alignment: alignment,
            scale: CurvedAnimation(
              parent: animation,
              curve: Interval(
                0.0,
                0.5,
                curve: curve,
              ),
            ),
            child: child,
          );
        case DialogTransitionType.fadeScale:
          return ScaleTransition(
            alignment: alignment,
            scale: CurvedAnimation(
              parent: animation,
              curve: Interval(
                0.00,
                0.50,
                curve: curve,
              ),
            ),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: curve,
              ),
              child: child,
            ),
          );
        case DialogTransitionType.rotate:
          return RotationTransition(
            alignment: alignment,
            turns: Tween<double>(begin: 1, end: 2).animate(
              CurvedAnimation(
                parent: animation,
                curve: Interval(0.0, 1.0, curve: curve),
              ),
            ),
            child: child,
          );
        case DialogTransitionType.scaleRotate:
          return ScaleTransition(
            alignment: alignment,
            scale: CurvedAnimation(
              parent: animation,
              curve: Interval(
                0.00,
                0.50,
                curve: curve,
              ),
            ),
            child: RotationTransition(
              alignment: alignment,
              turns: Tween<double>(begin: 1, end: 2).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Interval(0.0, 1.0, curve: curve),
                ),
              ),
              child: child,
            ),
          );
        case DialogTransitionType.fadeRotate:
          return RotationTransition(
            alignment: alignment,
            turns: Tween<double>(begin: 1, end: 2).animate(CurvedAnimation(
                parent: animation, curve: Interval(0.0, 1.0, curve: curve))),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: curve,
              ),
              child: child,
            ),
          );
        case DialogTransitionType.size:
          return Align(
            alignment: alignment,
            child: SizeTransition(
              sizeFactor: CurvedAnimation(
                parent: animation,
                curve: curve,
              ),
              axis: axis,
              child: child,
            ),
          );
        case DialogTransitionType.sizeFade:
          return Align(
            alignment: alignment,
            child: SizeTransition(
              sizeFactor: CurvedAnimation(
                parent: animation,
                curve: curve,
              ),
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: curve,
                ),
                child: child,
              ),
            ),
          );
        case DialogTransitionType.none:
          return child;
        default:
          return FadeTransition(
            opacity: animation,
            child: child,
          );
      }
    },
  );
}
