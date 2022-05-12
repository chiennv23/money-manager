import 'package:flutter/material.dart';

class FDefaultIconStyle extends InheritedTheme {
  FDefaultIconStyle({
    Key key,
    this.primaryColor,
    this.secondaryColor,
    this.color,
    this.size,
    @required this.child,
  });

  final Color primaryColor;

  final Color secondaryColor;

  final Color color;

  final double size;

  final Widget child;

  static FDefaultIconStyle of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FDefaultIconStyle>();
  }

  @override
  bool updateShouldNotify(FDefaultIconStyle oldWidget) {
    return true;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FDefaultIconStyle(
      key: key,
      color: color,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      size: size,
      child: child,
    );
  }
}
