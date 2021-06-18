import 'dart:math';

import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionWithDetails extends StatelessWidget {
  final TransactionDataType transactionType;
  final UserAccountType accountType;
  final UserAccountType withAccountType;
  final MoneyTransferType moneyTransferType;
  final double amount;
  final UserDetails userDetails;
  final SlotData slotData;

  TransactionWithDetails(
      {@required this.transactionType,
      @required this.accountType,
      @required this.withAccountType,
      @required this.moneyTransferType,
      @required this.amount,
      @required this.userDetails,
      @required this.slotData});

  double withImgSize = 40;

  Widget iconWidget = Container(
    height: 0,
    width: 0,
  );
  setIconWidget() {
    if (this.transactionType == 1) {
      // Real Transaction
      if (this.accountType == 0) {
        // User OR Wallet Transaction
        iconWidget = Container(
          height: withImgSize,
          width: withImgSize,
          child: Container(
            child: CustomIcon(
              icon: GPIcons.wallet,
              size: 26,
              color: qbAppTextColor,
            ),
          ),
        );
      } else {
        iconWidget = Container(
          height: withImgSize,
          width: withImgSize,
          child: Icon(
            // Change with Vault Icon
            FontAwesome.bank,
            size: 26,
            color: qbAppTextColor,
          ),
        );
      }
    } else if (this.transactionType == 2) {
      // Non Real Transaction
      if (this.withAccountType == 0) {
        // Transaction With User
        String imgUrl = "";
        if (this.userDetails.profilePicThumbnailUrl != null) {
          imgUrl = formatImgUrl(this.userDetails.profilePicThumbnailUrl);
        }
        iconWidget = DisplayPicture(
            imgUrl: imgUrl,
            isEditable: false,
            height: withImgSize,
            width: withImgSize,
            type: (this.userDetails.getGenderType() == UserGender.male)
                ? DisplayPictureType.profilePictureMale
                : DisplayPictureType.profilePictureFemale);
      } else if (this.withAccountType == 1) {
        // Transaction With Slot
        String imgUrl = formatImgUrl(this.slotData.thumbnailUrl);
        iconWidget = DisplayPicture(
            imgUrl: imgUrl,
            isEditable: false,
            height: withImgSize,
            width: withImgSize,
            type: DisplayPictureType.slotMainImage);
      } else if (this.withAccountType == 2) {
        // Transaction With App
        iconWidget = CustomIcon(
          icon: GPIcons.get_parked_logo,
          size: 40,
          color: qbAppPrimaryThemeColor,
        );
      }
    }
  }

  Widget subtitleAndNameWidget = Container(height: 0, width: 0);
  setSubtitleAndNameWidget() {
    // Setting withName
    String withName = "";
    String subtitle = "";
    switch (this.withAccountType) {
      case UserAccountType.user:
        withName = this.userDetails.firstName.trim() +
            " " +
            this.userDetails.lastName.trim();
        break;
      case UserAccountType.slot:
        withName = this.slotData.name.trim();
        break;
      case UserAccountType.admin:
        withName = appName;
    }

    // Setting Subtitle
    switch (this.transactionType) {
      case TransactionDataType.real:
        {
          // Real Transaction
          switch (this.moneyTransferType) {
            case MoneyTransferType.remove:
              subtitle = "Money Withdrawn";
              break;

            case MoneyTransferType.add:
              subtitle = "Money Added";
              break;
          }
          break;
        }
      case TransactionDataType.nonReal:
        {
          // Non Real Transaction
          switch (this.moneyTransferType) {
            case MoneyTransferType.remove:
              subtitle = "Debited To";
              break;

            case MoneyTransferType.add:
              subtitle = "Credited From";
              break;
          }
          break;
        }
    }

    subtitleAndNameWidget = Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(subtitle,
              style: GoogleFonts.yantramanav(
                  fontWeight: FontWeight.w500,
                  fontSize: 11.5,
                  color: qbDetailLightColor),
              textScaleFactor: 1,
              maxLines: 1),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            withName,
            style: GoogleFonts.yantramanav(
                fontWeight: FontWeight.w500,
                fontSize: 15.5,
                color: qbDetailDarkColor),
            textScaleFactor: 1,
            maxLines: 2,
          ),
        ),
      ],
    ));
  }

  Widget moneyTransferTypeArrow = Container(
    height: 0,
    width: 0,
  );
  setMoneyTransferTypeArrow() {
    IconData arrowIcon;
    Color arrowColor;
    if (this.moneyTransferType == 0) {
      arrowIcon = Entypo.down_bold;
      arrowColor = qbAppPrimaryRedColor;
    } else {
      arrowIcon = Entypo.up_bold;
      arrowColor = qbAppPrimaryGreenColor;
    }

    moneyTransferTypeArrow = Container(
      child: Icon(
        arrowIcon,
        size: 13.5,
        color: arrowColor,
      ),
    );
  }

  Widget amountWidget = Container();

  setAmountWidget() {
    amountWidget = Container(
      child: Text(
        "₹ ${this.amount.toStringAsFixed(2)}/-",
        style: GoogleFonts.roboto(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: qbDetailDarkColor),
        textScaleFactor: 1.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setIconWidget();
    setSubtitleAndNameWidget();
    setMoneyTransferTypeArrow();
    setAmountWidget();

    return Container(
      child: Row(
        children: [
          iconWidget,
          SizedBox(
            width: 12.5,
          ),
          Expanded(
            child: subtitleAndNameWidget,
          ),
          SizedBox(
            width: 7.5,
          ),
          moneyTransferTypeArrow,
          SizedBox(
            width: 5,
          ),
          amountWidget
        ],
      ),
    );
  }
}
