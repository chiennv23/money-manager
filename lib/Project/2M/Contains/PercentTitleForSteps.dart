import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Components/styles/text_style.dart';
import 'package:coresystem/Project/2M/Contains/skin/color_skin.dart';
import 'package:coresystem/Utils/CustomPaint.dart';
import 'package:flutter/material.dart';

class PercentTitleSteps extends StatelessWidget {
  final int step;
  final String title;
  final Color colorCirclePercent;
  final int totalStep;

  const PercentTitleSteps({
    Key key,
    this.step,
    this.title,
    this.totalStep = 3,
    this.colorCirclePercent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: FColorSkin.grey1_background,
          boxShadow: [FElevation.elevation2]),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 48,
            width: 48,
            margin: EdgeInsets.only(left: 19, right: 16, top: 16, bottom: 16),
            child: CustomPaint(
              foregroundPainter: CheckPercentSignUp(
                lineColor: FColorSkin.grey3_background,
                completeColor: colorCirclePercent ?? FColorSkin.primaryColor,
                completePercent: (100 / totalStep) * step,
                width: 5.0,
              ),
              child: Center(
                child: Text(
                  '$step/$totalStep',
                  style: FTextStyle.semibold16_24.copyWith(
                    color: FColorSkin.title,
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  'Bước $step',
                  style: FTextStyle.regular14_22
                      .copyWith(color: FColorSkin.subtitle),
                ),
              ),
              Text(
                '$title',
                style: FTextStyle.semibold14_22.copyWith(
                  color: FColorSkin.title,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
