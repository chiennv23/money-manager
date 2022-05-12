import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base_component.dart';

class FTextButton extends StatelessWidget {
  const FTextButton({
    Key key,
    @required this.child,
    // this.backgroundColor = Colors.blue,
    this.size = FButtonSize.size40,
    this.textColor = Colors.blue,
    @required this.onPressed,
  })  : this.isIcon = false,
        super(key: key);

  const FTextButton.icon({
    Key key,
    @required this.child,
    // this.backgroundColor = Colors.blue,
    this.size = FButtonSize.size40,
    this.textColor = Colors.blue,
    @required this.onPressed,
  })  : this.isIcon = true,
        super(key: key);

  final Widget child;
  final Color textColor;

  // final Color backgroundColor;
  final FButtonSize size;
  final VoidCallback onPressed;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      minSize: size.height,
      color: Colors.transparent,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.zero,
      child: Container(
        height: size.height,
        width: isIcon ? size.height : null,
        padding: isIcon ? null : size.padding,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: isIcon
              ? BorderRadius.circular(size.height / 2)
              : BorderRadius.all(size.borderRadius),
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
