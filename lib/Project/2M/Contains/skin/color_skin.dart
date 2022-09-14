import 'package:coresystem/Components/base_component.dart';
import 'package:flutter/material.dart';

Color _colorFromHex(String hexColor) {
  String hexCode;
  if (hexColor.startsWith('#')) {
    hexCode = hexColor.replaceFirst('#', '0xFF');
  } else {
    hexCode = hexColor.replaceFirst('', '0xFF');
  }
  return Color(int.parse('$hexCode'));
}

class FColorSkin {
  /// [Primary Color]
  static Color primaryColor = _colorFromHex('#366AE2');
  static Color primaryColorSub = _colorFromHex('#4D7AE5');
  static Color primaryColorHover = _colorFromHex('#799CEC');
  static Color primaryColorPressed = _colorFromHex('#1D50C9');
  static Color primaryColorActive = _colorFromHex('096DD9');
  static Color primaryColorTagBackground = _colorFromHex('#EDF2FD');
  static Color primaryColorBorderColor = _colorFromHex('#BCCDF5');

  /// [Secondary Color 1]
  static Color secondaryColor1 = _colorFromHex('#FC6B03');
  static Color secondaryColor1Sub = _colorFromHex('#FD8835');
  static Color secondaryColor1Hover = _colorFromHex('#FD974E');
  static Color secondaryColor1Pressed = _colorFromHex('#B14B02');
  static Color secondaryColor1Active = _colorFromHex('#B14B02');
  static Color secondaryColor1TagBackground = _colorFromHex('#FFEDE1');
  static Color secondaryColor1BorderColor = _colorFromHex('#FEC49A');

  /// [Secondary Color 2]
  static Color secondaryColor2 = _colorFromHex('13C2C2');
  static Color secondaryColor2Hover = _colorFromHex('36CFC9');
  static Color secondaryColor2Pressed = _colorFromHex('08979C');
  static Color secondaryColor2Active = _colorFromHex('08979C');
  static Color secondaryColor2TagBackground = _colorFromHex('E7F9F9');
  static Color secondaryColor2BorderColor = _colorFromHex('87E8DE');

  /// [Secondary Color 3]
  static Color secondaryColor3 = FColors.orange6;
  static Color secondaryColor3Hover = FColors.orange5;
  static Color secondaryColor3Pressed = FColors.orange7;
  static Color secondaryColor3Active = FColors.orange7;
  static Color secondaryColor3TagBackground = FColors.orange1;
  static Color secondaryColor3BorderColor = FColors.orange3;

  /// [Secondary Color 4]
  static Color secondaryColor4 = FColors.yellow6;
  static Color secondaryColor4Hover = FColors.yellow5;
  static Color secondaryColor4Pressed = FColors.yellow7;
  static Color secondaryColor4Active = FColors.yellow7;
  static Color secondaryColor4TagBackground = FColors.yellow1;
  static Color secondaryColor4BorderColor = FColors.yellow3;

  /// [Background Colors Usage]
  static Color grey1_background = FColors.grey1;
  static Color grey3_background = Color(0xFFF3F3F3);
  static Color grey4_background = FColors.grey4;
  static Color disableBackground = FColors.grey5;
  static Color grey9_background = FColors.grey9;

  /// [Typography Colors Usage]
  static Color onColorBackground = FColors.grey1;
  static Color disable = Color(0xffAEBCD0);
  static Color subtitle = Color(0xff6E87AA);
  static Color body = Color(0xff6E87AA);
  static const Color secondaryText = Color(0xff8C8C8C);
  static const Color primaryText = Color(0xff595959);
  static const Color title = Color(0xff1C2430);

  /// [Alert Info Color]
  static Color infoPrimary = _colorFromHex('1890FF');
  static Color infoPrimaryHover = FColors.blue5;
  static Color infoPrimaryPressed = FColors.blue7;
  static Color infoPrimaryActive = FColors.blue7;
  static Color infoPrimaryTagBackground = Color(0xFFE6F7FF);
  static Color infoPrimaryBorderColor = FColors.blue3;

  /// [Alert Success Color]
  static Color successPrimary = FColors.green6;
  static Color successPrimaryHover = FColors.green5;
  static Color successPrimaryPressed = FColors.green7;
  static Color successPrimaryActive = FColors.green7;
  static Color successPrimaryTagBackground = Color(0xFFEBFAEF);
  static Color successPrimaryBorderColor = FColors.green3;

  /// [Alert Warning Color]
  static Color warningPrimary = Color(0xffF37322);
  static Color warningPrimaryHover = FColors.orange5;
  static Color warningPrimaryPressed = FColors.orange7;
  static Color warningPrimaryActive = FColors.orange7;
  static Color warningPrimaryTagBackground = Color(0xFFFFF7E6);
  static Color warningPrimaryBorderColor = FColors.orange3;

  /// [Alert Error Color]
  static const Color errorPrimary = Color(0xFFF5222D);
  static Color errorPrimaryHover = FColors.red5;
  static Color errorPrimaryPressed = FColors.red7;
  static Color errorPrimaryActive = FColors.red7;
  static Color errorPrimaryTagBackground = Color(0xFFFDF2F4);
  static Color errorPrimaryBorderColor = FColors.red3;

  /// [Colorful Tags Colors Usage]
  static Color primaryTagBackgroundColor = FColors.blue1;
  static Color primaryTagBorderColor = FColors.blue3;
  static Color primaryTagTypographyColor = FColors.blue6;

  /// [Colors Transparent]
  static const Color transparent = Colors.transparent;

  static Color gradient1 = _colorFromHex('1961AE');
  static Color gradient2 = _colorFromHex('EC1F28');
  static Color certificate_covid = _colorFromHex('367D4E');
  static Color divider = _colorFromHex('367D4E');
}
