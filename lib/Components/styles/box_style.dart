import 'package:flutter/material.dart';

class FBoxSize {
  const FBoxSize({
    @required this.value,
    @required this.circleRadius,
    @required this.roundRadius,
    @required this.ratioValue,
  });

  final double value;
  final double ratioValue;
  final BorderRadius circleRadius;
  final BorderRadius roundRadius;

  static const FBoxSize size8 = FBoxSize(
      value: 8,
      roundRadius: BorderRadius.all(Radius.circular(2)),
      circleRadius: BorderRadius.all(Radius.circular(8)),
      ratioValue: 1);
  static const FBoxSize size16 = FBoxSize(
      value: 16,
      roundRadius: BorderRadius.all(Radius.circular(4)),
      circleRadius: BorderRadius.all(Radius.circular(16)),
      ratioValue: 1);
  static const FBoxSize size20 = FBoxSize(
      value: 20,
      roundRadius: BorderRadius.all(Radius.circular(4)),
      circleRadius: BorderRadius.all(Radius.circular(20)),
      ratioValue: 1);
  static const FBoxSize size24 = FBoxSize(
      value: 24,
      roundRadius: BorderRadius.all(Radius.circular(4)),
      circleRadius: BorderRadius.all(Radius.circular(24)),
      ratioValue: 1);
  static const FBoxSize size32 = FBoxSize(
      value: 32,
      roundRadius: BorderRadius.all(Radius.circular(8)),
      circleRadius: BorderRadius.all(Radius.circular(32)),
      ratioValue: 1);
  static const FBoxSize size40 = FBoxSize(
      value: 40,
      roundRadius: BorderRadius.all(Radius.circular(12)),
      circleRadius: BorderRadius.all(Radius.circular(40)),
      ratioValue: 1);
  static const FBoxSize size48 = FBoxSize(
      value: 48,
      roundRadius: BorderRadius.all(Radius.circular(12)),
      circleRadius: BorderRadius.all(Radius.circular(48)),
      ratioValue: 1);
  static const FBoxSize size56 = FBoxSize(
      value: 56,
      roundRadius: BorderRadius.all(Radius.circular(12)),
      circleRadius: BorderRadius.all(Radius.circular(56)),
      ratioValue: 1);
  static const FBoxSize size64 = FBoxSize(
      value: 64,
      roundRadius: BorderRadius.all(Radius.circular(12)),
      circleRadius: BorderRadius.all(Radius.circular(64)),
      ratioValue: 1);
  static const FBoxSize size72 = FBoxSize(
      value: 72,
      roundRadius: BorderRadius.all(Radius.circular(12)),
      circleRadius: BorderRadius.all(Radius.circular(72)),
      ratioValue: 1);
  static const FBoxSize size80 = FBoxSize(
      value: 80,
      roundRadius: BorderRadius.all(Radius.circular(12)),
      circleRadius: BorderRadius.all(Radius.circular(80)),
      ratioValue: 1);
  static const FBoxSize size88 = FBoxSize(
      value: 88,
      roundRadius: BorderRadius.all(Radius.circular(12)),
      circleRadius: BorderRadius.all(Radius.circular(88)),
      ratioValue: 1);
  static const FBoxSize size96 = FBoxSize(
      value: 96,
      roundRadius: BorderRadius.all(Radius.circular(12)),
      circleRadius: BorderRadius.all(Radius.circular(96)),
      ratioValue: 1);
  static const FBoxSize size104 = FBoxSize(
      value: 104,
      roundRadius: BorderRadius.all(Radius.circular(12)),
      circleRadius: BorderRadius.all(Radius.circular(104)),
      ratioValue: 1);
  static const FBoxSize ratio_4_3 = FBoxSize(
      value: double.infinity,
      roundRadius: BorderRadius.all(Radius.circular(12)),
      circleRadius: BorderRadius.all(Radius.circular(12)),
      ratioValue: 4 / 3);

  static const FBoxSize ratio_2_1 = FBoxSize(
      value: double.infinity,
      roundRadius: BorderRadius.all(Radius.circular(12)),
      circleRadius: BorderRadius.all(Radius.circular(12)),
      ratioValue: 2 / 1);

  static const FBoxSize ratio_1_1 = FBoxSize(
      value: double.infinity,
      roundRadius: BorderRadius.all(Radius.circular(12)),
      circleRadius: BorderRadius.all(Radius.circular(12)),
      ratioValue: 1 / 1);

  FBoxSize copyWith(
      {double value,
      BorderRadius circleRadius,
      BorderRadius roundRadius,
      double ratioValue}) {
    return FBoxSize(
        value: value ?? this.value,
        roundRadius: roundRadius ?? this.roundRadius,
        circleRadius: circleRadius ?? this.circleRadius,
        ratioValue: ratioValue ?? this.ratioValue);
  }
}

enum FBoxShape { circle, rect, round }
