import 'package:flutter/material.dart';

import '../base_component.dart';

class FListTile extends StatefulWidget {
  const FListTile({
    Key key,
    this.avatar,
    @required this.title,
    this.subtitle,
    this.action,
    this.size = FListTileSize.size48,
    this.onTap,
    this.backgroundColor = FColors.grey1,
    this.reversed = false,
    this.rounded = false,
    this.padding,
    this.border,
  }) : super(key: key);

  final FListTileSize size;
  final GestureTapCallback onTap;
  final Widget avatar;
  final Widget title;
  final Widget subtitle;
  final Widget action;
  final Color backgroundColor;
  final bool reversed;
  final bool rounded;
  final EdgeInsets padding;
  final Border border;

  @override
  _FListTileState createState() => _FListTileState();
}

class _FListTileState extends State<FListTile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: widget.rounded
            ? BorderRadius.all(widget.size.borderRadius)
            : BorderRadius.zero,
      ),
      child: InkWell(
        borderRadius: widget.rounded
            ? BorderRadius.all(widget.size.borderRadius)
            : BorderRadius.zero,
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            // color: widget.backgroundColor,
            borderRadius: widget.rounded
                ? BorderRadius.all(widget.size.borderRadius)
                : BorderRadius.zero,
          ),
          height: widget.size.height,
          padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection:
                widget.reversed ? TextDirection.rtl : TextDirection.ltr,
            children: [
              if (widget.avatar != null)
                Container(
                  margin: widget.reversed
                      ? EdgeInsets.fromLTRB(12, 0, 0, 0)
                      : EdgeInsets.fromLTRB(0, 0, 12, 0),
                  child: widget.avatar,
                ),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    border: widget.border,
                    // borderRadius: widget.rounded
                    //     ? BorderRadius.all(widget.size.borderRadius)
                    //     : BorderRadius.zero,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: DefaultTextStyle(
                                style: FTextStyle.regular14_22
                                    .copyWith(color: FColors.grey10),
                                child: widget.title,
                              ),
                            ),
                            if (widget.subtitle != null)
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                child: DefaultTextStyle(
                                  style: FTextStyle.regular12_16
                                      .copyWith(color: FColors.grey7),
                                  child: widget.subtitle,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (widget.action != null)
                        Container(
                          margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: widget.action,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
