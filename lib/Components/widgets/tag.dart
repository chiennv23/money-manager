import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base_component.dart';

class FTag extends StatelessWidget {
  const FTag({
    Key key,
    @required this.child,
    this.size = FTagSize.size40,
    @required this.onPressed,
    this.borderColor = FColors.blue6,
    this.textColor = FColors.blue6,
    this.backgroundColor = FColors.blue1,
  }) : super(key: key);

  final Widget child;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final FTagSize size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      minSize: size.height < 40 ? 40 : size.height,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.zero,
      color: Colors.transparent,
      child: Container(
        height: size.height,
        padding: size.padding.subtract(EdgeInsets.symmetric(horizontal: 1)),
        decoration: BoxDecoration(
          border:
              Border.fromBorderSide(BorderSide(width: 1, color: borderColor)),
          borderRadius: BorderRadius.circular(size.height / 2),
          color: backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextStyle(
              overflow: TextOverflow.ellipsis,
              style: size.textStyle.copyWith(height: 1, color: textColor),
              maxLines: 1,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
