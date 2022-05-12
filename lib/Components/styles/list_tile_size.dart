import 'package:flutter/material.dart';

class FListTileSize {
  const FListTileSize({
    @required this.height,
    @required this.borderRadius,
  });

  final double height;
  final Radius borderRadius;

  static const FListTileSize size32 = FListTileSize(
    height: 32,
    borderRadius: Radius.circular(4.0),
  );

  static const FListTileSize size40 = FListTileSize(
    height: 40,
    borderRadius: Radius.circular(4.0),
  );

  static const FListTileSize size48 = FListTileSize(
    height: 48,
    borderRadius: Radius.circular(4.0),
  );

  static const FListTileSize size56 = FListTileSize(
    height: 56,
    borderRadius: Radius.circular(4.0),
  );

  static const FListTileSize size64 = FListTileSize(
    height: 64,
    borderRadius: Radius.circular(8.0),
  );

  static const FListTileSize size68 = FListTileSize(
    height: 68,
    borderRadius: Radius.circular(12.0),
  );

  static const FListTileSize size72 = FListTileSize(
    height: 72,
    borderRadius: Radius.circular(8.0),
  );

  static const FListTileSize size80 = FListTileSize(
    height: 80,
    borderRadius: Radius.circular(8.0),
  );

  static const FListTileSize size88 = FListTileSize(
    height: 88,
    borderRadius: Radius.circular(8.0),
  );
  static const FListTileSize size96 = FListTileSize(
    height: 96,
    borderRadius: Radius.circular(8.0),
  );

  FListTileSize copywith({
    double height,
    Radius borderRadius,
  }) {
    return FListTileSize(
      borderRadius: borderRadius ?? this.borderRadius,
      height: height ?? this.height,
    );
  }
}
