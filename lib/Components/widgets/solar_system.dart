import 'package:flutter/material.dart';

import '../base_component.dart';

class SolarSystem extends StatelessWidget {
  final double radiusCircle1;
  final double radiusCircle2;
  final double radiusCircle3;
  final double rotate1;
  final double rotate2;
  final double rotate3;
  final Color colorCircle1;
  final Color colorCircle2;
  final Color colorCircle3;
  final Color colorBorder;
  final bool noCircle;

  const SolarSystem({
    Key key,
    this.rotate1 = 35,
    this.rotate2 = 150,
    this.radiusCircle1 = 5,
    this.radiusCircle2 = 5,
    this.radiusCircle3 = 7,
    this.colorCircle1 = FColors.grey1,
    this.colorCircle2 = FColors.blue6,
    this.colorBorder = FColors.blue6,
    this.noCircle = false,
    this.rotate3 = 55,
    this.colorCircle3 = FColors.blue6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double calW = wid / 2;
    return Container(
      alignment: Alignment.center,
      width: wid,
      height: wid,
      color: FColors.transparent,
      child: Stack(
        // clipBehavior: Clip.hardEdge,
        children: [
          RotationTransition(
            turns: AlwaysStoppedAnimation(rotate1 / 360),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: wid,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 0.5,
                      color: colorBorder,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                if (noCircle == false)
                  Positioned(
                    top: -radiusCircle1,
                    left: calW,
                    child: CircleAvatar(
                      radius: radiusCircle1,
                      backgroundColor: colorCircle1,
                    ),
                  ),
                if (noCircle == false)
                  Positioned(
                    bottom: -radiusCircle3,
                    left: calW,
                    child: CircleAvatar(
                      radius: radiusCircle3,
                      backgroundColor: colorCircle3.withOpacity(1),
                    ),
                  ),
              ],
            ),
          ),
          RotationTransition(
            turns: AlwaysStoppedAnimation(rotate2 / 360),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: wid,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: FColors.transparent,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                if (noCircle == false)
                  Positioned(
                    bottom: -radiusCircle2,
                    left: calW,
                    child: CircleAvatar(
                      radius: radiusCircle2,
                      backgroundColor: colorCircle2.withOpacity(1),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
