import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../base_component.dart';

class FCircleProcess extends StatelessWidget {
  const FCircleProcess({
    Key key,
    @required this.process,
    this.strokeWidth = 8,
    this.child,
    this.paintColor = FColors.blue6,
    this.bgPaintColor = FColors.grey3,
  }) : super(key: key);

  final double process;
  final double strokeWidth;
  final Color paintColor;
  final Color bgPaintColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final d = constraints.maxWidth;
          return Container(
            child: CustomPaint(
              painter: _CirclePainter(
                process: process,
                paintColor: paintColor,
                bgPaintColor: bgPaintColor,
                strokeWidth: strokeWidth,
              ),
              child: Container(
                margin: EdgeInsets.all(
                    d / 2 - (d / sqrt2) / 2 + (strokeWidth / 2 * sqrt2)),
                alignment: Alignment.center,
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  _CirclePainter({
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

    final processPath = Path();
    final bgPath = Path();

    final rect = Rect.fromCircle(
      center: Offset(size.width * 0.5, size.height * 0.5),
      radius: (size.width - strokeWidth) * 0.5,
    );

    if (process < 1) {
      processPath.arcTo(rect, pi * (3 / 2), pi * 2 * process, false);
    } else {
      processPath.addOval(rect);
    }

    bgPath.addOval(rect);

    canvas.drawPath(bgPath, _bgPaint);
    canvas.drawPath(processPath, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
