import 'package:flutter/material.dart';

import '../base_component.dart';

class FDivider extends StatelessWidget {
  const FDivider({
    Key key,
    this.color = FColors.grey4,
    this.endIndent,
    this.height = 1.0,
    this.indent,
    this.thickness,
  }) : super(key: key);

  final Color color;
  final double endIndent;
  final double height;
  final double indent;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      key: key,
      color: color,
      endIndent: endIndent,
      height: height,
      indent: indent,
      thickness: thickness,
    );
  }
}
