import 'package:flutter/material.dart';

import '../base_component.dart';

class FLinearProcess extends StatelessWidget {
  const FLinearProcess({
    Key key,
    @required this.process,
    this.size = const Size(148, 148),
    this.strokeWidth = 8,
    this.child,
    this.paintColor = FColors.blue6,
    this.bgPaintColor = FColors.grey3,
  }) : super(key: key);

  final double process;
  final Size size;
  final double strokeWidth;
  final Color paintColor;
  final Color bgPaintColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: Size(400, strokeWidth),
        painter: _LinearPainter(
          process: process,
          strokeWidth: strokeWidth,
          paintColor: paintColor,
          bgPaintColor: bgPaintColor,
        ),
      ),
    );
  }
}

class _LinearPainter extends CustomPainter {
  _LinearPainter({
    @required this.process,
    @required this.strokeWidth,
    @required this.paintColor,
    @required this.bgPaintColor,
  });

  final double process;
  final double strokeWidth;
  final Color paintColor;
  final Color bgPaintColor;

  @override
  void paint(Canvas canvas, Size size) {
    // forgeround paint
    final _paint = Paint()
      ..color = paintColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // background paint
    final _bgPaint = Paint()
      ..color = bgPaintColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(0, 0), Offset(size.width, 0), _bgPaint);
    canvas.drawLine(Offset(0, 0), Offset(size.width * process, 0), _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
