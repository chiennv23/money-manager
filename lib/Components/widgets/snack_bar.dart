import 'package:flutter/material.dart';

import '../base_component.dart';

showSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("ABc"),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

class FSnackBar extends StatelessWidget {
  const FSnackBar({
    Key key,
    this.leading,
    @required this.title,
    this.action,
    this.status = FSnackBarStatus.infor,
    this.isSoft = true,
  }) : super(key: key);

  final Widget leading;
  final Widget title;
  final Widget action;
  final bool isSoft;
  final FSnackBarStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
      decoration: BoxDecoration(
        color: isSoft ? status.secondaryColor : status.primaryColor,
        borderRadius: isSoft ? BorderRadius.circular(8) : null,
      ),
      height: 48,
      child: Row(
        children: [
          Container(
            child: FMediaView(
              shape: FBoxShape.rect,
              backgroundColor: FColors.transparent,
              child: Container(),
            ),
          ),
          Expanded(
            child: DefaultTextStyle(
              style: FTextStyle.regular14_22.copyWith(
                  color: isSoft ? status.primaryColor : status.secondaryColor),
              child: Text("Defaul message"),
            ),
          ),
          Container(
            child: Text("Button"),
          )
        ],
      ),
    );
  }
}
