import 'package:flutter/material.dart';

class FRadioSize {
  const FRadioSize({
    @required this.innerRadius,
    @required this.outterRadius,
  });

  final double innerRadius;
  final double outterRadius;

  static const size16 = FRadioSize(
    innerRadius: 4,
    outterRadius: 8,
  );

  static const size20 = FRadioSize(
    innerRadius: 5,
    outterRadius: 10,
  );

  static const size24 = FRadioSize(
    innerRadius: 6,
    outterRadius: 12,
  );

  FRadioSize copyWith({
    double innerRadius,
    double outterRadius,
  }) {
    return FRadioSize(
      innerRadius: innerRadius ?? this.innerRadius,
      outterRadius: outterRadius ?? this.outterRadius,
    );
  }
}
