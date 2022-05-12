import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../base_component.dart';

class FIcon extends StatelessWidget {
  const FIcon({
    Key key,
    @required this.icon,
    this.color,
    this.size,
  })  : primaryColor = null,
        secondaryColor = null,
        super(key: key);

  const FIcon.twoTone({
    Key key,
    @required this.icon,
    this.primaryColor,
    this.secondaryColor,
    this.size,
  })  : color = null,
        super(key: key);

  /// string icon thông qua static field của class FIcons
  final String icon;

  /// tone màu icon thứ nhất [twotone]
  final Color primaryColor;

  /// tone màu icon thứ 2 [twotone]
  final Color secondaryColor;

  /// màu icon mặc định là màu grey10
  final Color color;

  /// size icon, mặc định là 24
  final double size;

  @override
  Widget build(BuildContext context) {
    String _icon;
    final _defaultIconStyle = FDefaultIconStyle.of(context);

    final _effectiveColor = color ?? _defaultIconStyle?.color ?? FColors.grey10;
    final _effectivePColor =
        color ?? _defaultIconStyle?.primaryColor ?? FColors.grey1;
    final _effectiveSColor =
        color ?? _defaultIconStyle?.secondaryColor ?? FColors.blue6;
    final _effectiveSize = size ?? _defaultIconStyle?.size ?? 24;

    if (_effectiveColor != null) {
      _icon = icon
          .replaceAll('fill="black"',
              'fill="#${_effectiveColor.toString().substring(10, 16)}"')
          .replaceAll('stroke="black"',
              'stroke="#${_effectiveColor.toString().substring(10, 16)}"');
    } else {
      _icon = icon
          .replaceAll('fill="#E6F7FF"',
              'fill="#${_effectivePColor.toString().substring(10, 16)}"')
          .replaceAll('fill="#1890FF"',
              'fill="#${_effectiveSColor.toString().substring(10, 16)}"');
    }

    return SvgPicture.string(
      _icon,
      height: _effectiveSize,
      width: _effectiveSize,
    );
  }
}
