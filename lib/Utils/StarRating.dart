import 'package:coresystem/Components/base_component.dart';
import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;
  final double sizeStar;
  final double heightStar;

  StarRating(
      {this.starCount = 5,
      this.rating = .0,
      this.onRatingChanged,
      this.color,
      this.sizeStar = 32,
      this.heightStar = 56});

  Widget buildStar(BuildContext context, int index) {
    FIcon icon;
    if (index >= rating) {
      icon = FIcon(
        color: FColors.grey4,
        icon: FFilled.star,
        size: sizeStar,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = FIcon(
        color: FColors.gold6,
        icon: FFilled.haft_star,
        size: sizeStar,
      );
    } else {
      icon = FIcon(
        color: FColors.gold6,
        icon: FFilled.star,
        size: sizeStar,
      );
    }
    return new InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightStar,
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        runAlignment: WrapAlignment.center,
        children: List.generate(
          starCount,
          (index) => buildStar(context, index),
        ),
      ),
    );
  }
}
