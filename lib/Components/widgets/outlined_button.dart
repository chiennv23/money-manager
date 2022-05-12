import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base_component.dart';

class FOutlinedButton extends StatelessWidget {
  const FOutlinedButton({
    Key key,
    @required this.child,
    this.size = FButtonSize.size40,
    @required this.onPressed,
    this.borderColor = Colors.blue,
    this.textColor = Colors.blue,
  })  : this.isIcon = false,
        super(key: key);

  const FOutlinedButton.icon({
    Key key,
    @required this.child,
    this.size = FButtonSize.size40,
    @required this.onPressed,
    this.borderColor = Colors.blue,
    this.textColor = Colors.blue,
  })  : this.isIcon = true,
        super(key: key);

  final Widget child;
  final Color borderColor;
  final Color textColor;
  final FButtonSize size;
  final VoidCallback onPressed;
  final bool isIcon;

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
        width: isIcon ? size.height : null,
        padding: !isIcon
            ? size.padding.subtract(EdgeInsets.symmetric(horizontal: 1))
            : null,
        decoration: BoxDecoration(
          border:
              Border.fromBorderSide(BorderSide(width: 1, color: borderColor)),
          borderRadius: !isIcon
              ? BorderRadius.all(size.borderRadius)
              : BorderRadius.circular(size.height / 2),
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
