import 'dart:math';
import 'package:flutter/material.dart';

class CheckPercentSignUp extends CustomPainter{
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;
  CheckPercentSignUp({this.lineColor,this.completeColor,this.completePercent,this.width});
  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    final complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    final center  = Offset(size.width/2, size.height/2);
    final radius  = min(size.width/2,size.height/2);
    canvas.drawCircle(
        center,
        radius,
        line
    );
    final arcAngle = 2*pi* (completePercent/100);
    canvas.drawArc(
        Rect.fromCircle(center: center,radius: radius),
        -pi/2,
        arcAngle,
        false,
        complete
    );
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
