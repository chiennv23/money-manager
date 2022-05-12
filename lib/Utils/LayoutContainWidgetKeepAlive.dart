import 'package:flutter/material.dart';

class LayoutContainWidgetKeepAlive extends StatefulWidget {
  final Widget child;

  const LayoutContainWidgetKeepAlive({@required this.child, Key key})
      : super(key: key);

  @override
  _LayoutContainWidgetKeepAliveState createState() =>
      _LayoutContainWidgetKeepAliveState();
}

class _LayoutContainWidgetKeepAliveState
    extends State<LayoutContainWidgetKeepAlive>
    with AutomaticKeepAliveClientMixin<LayoutContainWidgetKeepAlive> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(child: widget.child);
  }

  @override
  bool get wantKeepAlive => true;
}
