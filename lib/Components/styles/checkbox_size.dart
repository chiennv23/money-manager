import 'package:flutter/material.dart';

class FCheckboxSize {
  const FCheckboxSize({
    @required this.size,
    @required this.radius,
    @required this.strokeWidth,
  });

  final double size;
  final Radius radius;
  final double strokeWidth;

  static const size16 = FCheckboxSize(
    size: 16,
    radius: Radius.circular(4),
    strokeWidth: 1,
  );

  static const size20 = FCheckboxSize(
    size: 20,
    radius: Radius.circular(4),
    strokeWidth: 1,
  );

  static const size24 = FCheckboxSize(
    size: 24,
    radius: Radius.circular(4),
    strokeWidth: 1,
  );

  FCheckboxSize copyWith({
    double size,
    Radius radius,
    double strokeWidth,
  }) {
    return FCheckboxSize(
      size: size ?? this.size,
      radius: radius ?? this.radius,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }
}
