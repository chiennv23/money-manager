import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../base_component.dart';

class FMediaView extends StatelessWidget {
  const FMediaView({
    Key key,
    this.size = FBoxSize.size48,
    this.shape = FBoxShape.round,
    @required this.child,
    this.backgroundColor = FColors.grey4,
  }) : super(key: key);

  final FBoxShape shape;
  final FBoxSize size;
  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final _borderRadius = shape == FBoxShape.circle
        ? size.circleRadius
        : shape == FBoxShape.round
            ? size.roundRadius
            : BorderRadius.zero;

    return Container(
      width: size.value,
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        color: backgroundColor,
      ),
      child: AspectRatio(
        aspectRatio: size.ratioValue,
        child: ClipRRect(
          borderRadius: _borderRadius,
          child: child,
        ),
      ),
    );
  }
}

class FBoundingBox extends StatelessWidget {
  const FBoundingBox({
    Key key,
    this.size = FBoxSize.size48,
    this.shape = FBoxShape.round,
    this.child,
    this.backgroundColor = FColors.grey4,
    this.topItem,
    this.bottomItem,
    this.border,
  }) : super(key: key);

  final FBoxShape shape;
  final FBoxSize size;
  final Widget child;
  final Color backgroundColor;
  final Widget topItem;
  final Widget bottomItem;
  final BoxBorder border;

  @override
  Widget build(BuildContext context) {
    final _borderRadius = shape == FBoxShape.circle
        ? size.circleRadius
        : shape == FBoxShape.round
        ? size.roundRadius
        : BorderRadius.zero;

    return Container(
      height: size.value,
      width: size.value,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        color: backgroundColor,
        border: border,
      ),
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: topItem == null && bottomItem == null
            ? child
            : Stack(
          alignment: Alignment.center,
          children: [
            child,
            topItem != null
                ? Positioned(
              child: topItem,
              top: 0,
              right: 0,
            )
                : Container(),
            bottomItem != null
                ? Positioned(
              child: bottomItem,
              bottom: 0,
              right: 0,
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
