import 'package:flutter/material.dart';

import '../base_component.dart';

class FAppBar extends StatefulWidget implements PreferredSizeWidget {
  FAppBar({
    Key key,
    this.leading,
    this.title,
    this.actions,
    this.centerTitle = false,
    this.leadingWidth = 48,
    this.brightness = Brightness.light,
    this.backgroundColor = FColors.grey1,
    this.bottom,
    this.shape,
    this.toolbarHeight = 48,
    this.elevation = 0,
    this.automaticallyImplyLeading = false,
    this.flexibleSpace,
  }) : super(key: key);

  FAppBar.modal({
    Key key,
    this.leading,
    this.title,
    this.actions,
    this.centerTitle = false,
    this.leadingWidth,
    this.brightness = Brightness.light,
    this.backgroundColor = FColors.grey1,
    this.bottom,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    this.toolbarHeight = 56,
    this.elevation = 0,
    this.automaticallyImplyLeading = false,
    this.flexibleSpace,
  });

  final Brightness brightness;
  final Color backgroundColor;
  final double leadingWidth;
  final double toolbarHeight;
  final double elevation;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final ShapeBorder shape;
  final Widget leading;
  final Widget title;
  final Widget flexibleSpace;
  final List<Widget> actions;
  final PreferredSizeWidget bottom;

  @override
  _FAppBarState createState() => _FAppBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(toolbarHeight + (bottom?.preferredSize?.height ?? 0));
}

class _FAppBarState extends State<FAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor,
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      toolbarHeight: widget.toolbarHeight,
      leadingWidth: widget.leadingWidth,
      elevation: widget.elevation,
      leading: widget.leading,
      title: widget.title == null
          ? null
          : DefaultTextStyle(
              style: FTextStyle.semibold16_24.copyWith(color: FColors.grey9),
              child: widget.title,
            ),
      actions: widget.actions,
      bottom: widget.bottom,
      centerTitle: widget.centerTitle,
      shape: widget.shape,
      flexibleSpace: widget.flexibleSpace,
    );
  }
}
