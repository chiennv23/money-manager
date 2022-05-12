import 'package:flutter/material.dart';

import 'text_style.dart';

class FTagSize {
  const FTagSize({
    @required this.height,
    @required this.padding,
    @required this.textStyle,
  });

  final double height;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;

  static const FTagSize size24 = FTagSize(
    height: 24,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    textStyle: FTextStyle.regular12_16,
  );

  static const FTagSize size32 = FTagSize(
    height: 32,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    textStyle: FTextStyle.regular12_16,
  );

  static const FTagSize size40 = FTagSize(
    height: 40,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
    textStyle: FTextStyle.regular14_22,
  );

  static const FTagSize size48 = FTagSize(
    height: 48,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    textStyle: FTextStyle.semibold16_24,
  );

  FTagSize copyWith({
    double height,
    EdgeInsetsGeometry padding,
    Radius borderRadius,
    TextStyle textStyle,
  }) {
    return FTagSize(
      height: height ?? this.height,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}

class FBorderType {
  const FBorderType({@required this.dashPattern});

  final List<double> dashPattern;

  static const FBorderType solid = FBorderType(dashPattern: [1, 0]);
  static const FBorderType dash = FBorderType(dashPattern: [1, 2]);
}
