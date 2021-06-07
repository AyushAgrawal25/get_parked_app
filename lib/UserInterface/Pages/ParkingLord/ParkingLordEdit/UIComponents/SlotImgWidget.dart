import 'package:getparked/StateManagement/Models/SlotImageData.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getparked/Utils/DomainUtils.dart';

class SlotImgWidget extends StatelessWidget {
  double verticalMargin;
  double horizontalMargin;
  double height;
  double width;
  int imgIndex;
  SlotImageData slotImageData;
  Function(SlotImageData, int) onPressed;

  SlotImgWidget(
      {@required this.slotImageData,
      this.height,
      this.width,
      this.imgIndex,
      this.horizontalMargin,
      this.verticalMargin,
      this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
          onTap: () {
            SystemSound.play(SystemSoundType.click);
            this.onPressed(this.slotImageData, this.imgIndex);
          },
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: this.verticalMargin,
                horizontal: this.horizontalMargin),
            child: DisplayPicture(
              imgUrl: formatImgUrl(this.slotImageData.imageUrl),
              height: this.height - (2 * verticalMargin),
              width: this.width - (2 * horizontalMargin),
              isEditable: false,
              isElevated: false,
              borderRadius: BorderRadius.circular(5),
            ),
          )),
    );
  }
}
