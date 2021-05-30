import 'package:getparked/UserInterface/Widgets/Rating/RatingTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class RatingsButton extends StatefulWidget {
  Function(int) onRate;
  RatingsButton({@required this.onRate});
  @override
  _RatingsButtonState createState() => _RatingsButtonState();
}

class _RatingsButtonState extends State<RatingsButton> {
  int ratingValue = 0;
  @override
  Widget build(BuildContext context) {
    List<RatingStarButton> ratingStars = [];
    for (int i = 0; i < 5; i++) {
      ratingStars.add(
        RatingStarButton(
            index: i,
            isSelected: (ratingValue > i),
            onStarPressed: onRatingStarPressed),
      );
    }
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: ratingStars,
      ),
    );
  }

  onRatingStarPressed(int index) {
    setState(() {
      ratingValue = index + 1;
    });
    widget.onRate(ratingValue);
  }
}

class RatingStarButton extends StatefulWidget {
  bool isSelected;
  int index;
  Function(int) onStarPressed;

  RatingStarButton({
    @required this.index,
    @required this.isSelected,
    @required this.onStarPressed,
  });
  @override
  _RatingStarButtonState createState() => _RatingStarButtonState();
}

class _RatingStarButtonState extends State<RatingStarButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 7.5,
        ),
        child: Icon(
          (widget.isSelected) ? FontAwesome.star : FontAwesome.star_empty,
          color: (widget.isSelected)
              ? qbRatingStarFilledColor
              : qbRatingStarEmptyColor,
          size: 30,
        ),
      ),
      onTap: () {
        SystemSound.play(SystemSoundType.click);
        widget.onStarPressed(widget.index);
      },
    );
  }
}
