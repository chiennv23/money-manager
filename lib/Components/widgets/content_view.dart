import 'package:flutter/material.dart';

import '../base_component.dart';

class FContentView extends StatelessWidget {
  const FContentView(
      {Key key,
      @required this.title,
      this.subtitle,
      this.content,
      this.alignment = CrossAxisAlignment.start})
      : super(key: key);

  final Widget title;
  final Widget subtitle;
  final Widget content;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: alignment,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: DefaultTextStyle(
              child: title,
              style: FTextStyle.semibold16_24.copyWith(color: FColors.grey10),
            ),
          ),
          if (subtitle != null)
            Container(
              margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
              child: DefaultTextStyle(
                child: subtitle,
                style: FTextStyle.regular12_16.copyWith(color: FColors.grey7),
              ),
            ),
          if (content != null)
            Container(
              margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: DefaultTextStyle(
                child: content,
                style: FTextStyle.regular12_16.copyWith(color: FColors.grey9),
              ),
            ),
        ],
      ),
    );
  }
}
