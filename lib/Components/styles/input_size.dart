import 'package:flutter/material.dart';

class FInputSize {
  const FInputSize({
    @required this.height,
    @required this.borderRadius,
    @required this.contentPadding,
  });

  final double height;
  final Radius borderRadius;
  final EdgeInsetsGeometry contentPadding;

  static const FInputSize size32 = FInputSize(
    height: 32,
    borderRadius: Radius.circular(8.0),
    contentPadding: EdgeInsets.symmetric(vertical: 4),
  );

  static const FInputSize size40 = FInputSize(
    height: 40,
    borderRadius: Radius.circular(8.0),
    contentPadding: EdgeInsets.symmetric(vertical: 8),
  );

  static const FInputSize size48 = FInputSize(
    height: 48,
    borderRadius: Radius.circular(8.0),
    contentPadding: EdgeInsets.symmetric(vertical: 12),
  );

  static const FInputSize size56 = FInputSize(
    height: 56,
    borderRadius: Radius.circular(8.0),
    contentPadding: EdgeInsets.symmetric(vertical: 10),
  );

  static const FInputSize size64 = FInputSize(
    height: 64,
    borderRadius: Radius.circular(8.0),
    contentPadding: EdgeInsets.symmetric(vertical: 10),
  );

  FInputSize copyWith({
    double height,
    Radius borderRadius,
    EdgeInsetsGeometry contentPadding,
  }) {
    return FInputSize(
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      contentPadding: contentPadding ?? this.contentPadding,
    );
  }
}
