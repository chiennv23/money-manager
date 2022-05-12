import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base_component.dart';

class FDashedButton extends StatelessWidget {
  const FDashedButton({
    Key key,
    @required this.child,
    this.size = FButtonSize.size40,
    @required this.onPressed,
    this.borderColor = FColors.blue6,
    this.textColor = FColors.blue6,
  })  : this.isIcon = false,
        super(key: key);

  const FDashedButton.icon({
    Key key,
    @required this.child,
    this.size = FButtonSize.size40,
    @required this.onPressed,
    this.borderColor = FColors.blue6,
    this.textColor = FColors.blue6,
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
      child: DottedBorder(
        strokeWidth: 1.0,
        dashPattern: [2, 2],
        color: borderColor,
        padding: EdgeInsets.zero,
        borderType: BorderType.RRect,
        radius: !isIcon ? size.borderRadius : Radius.circular(size.height / 2),
        child: Container(
          height: size.height,
          width: isIcon ? size.height : null,
          padding: isIcon ? null : size.padding,
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
      ),
    );
  }
}
