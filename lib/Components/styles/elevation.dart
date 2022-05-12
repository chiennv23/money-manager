import 'package:flutter/material.dart';

class FElevation {
  static BoxShadow get elevation1 => BoxShadow(
      offset: Offset(0, 2.0),
      blurRadius: 15.0,
      color: Color.fromRGBO(0, 0, 0, 0.1));
  static BoxShadow get elevation2 => BoxShadow(
      offset: Offset(0, 4.0),
      blurRadius: 20.0,
      color: Color.fromRGBO(0, 0, 0, 0.03));
  static BoxShadow get elevation3 => BoxShadow(
      offset: Offset(0, 1.0),
      blurRadius: 0,
      color: Color.fromRGBO(0, 0, 0, 0.05));
  static BoxShadow get elevation4 => BoxShadow(
      offset: Offset(0, -1.0),
      blurRadius: 0,
      color: Color.fromRGBO(0, 0, 0, 0.05));
}
