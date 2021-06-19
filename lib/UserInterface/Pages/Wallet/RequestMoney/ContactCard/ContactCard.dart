import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/StateManagement/Models/ContactData.dart';
import 'package:getparked/UserInterface/Pages/Wallet/RequestMoney/SendPaymentRequest/SendPaymentRequest.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/WrapButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactCard extends StatefulWidget {
  ContactData contactData;
  double amount;

  ContactCard({@required this.contactData, this.amount});

  @override
  _ContactCardState createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    String avatar = "";
    widget.contactData.displayName.split(" ").forEach((name) {
      if (avatar.length < 2) {
        if (name.length > 0) {
          avatar += name[0];
        }
      }
    });

    String dialCode = "+91";
    if (widget.contactData.dialCode != null) {
      dialCode = widget.contactData.dialCode;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  height: 45,
                  width: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: qbAppPrimaryBlueColor,
                      borderRadius: BorderRadius.circular(360)),
                  child: (widget.contactData.profilePicUrl != null)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(360),
                          child: Image.network(
                            formatImgUrl(widget.contactData.profilePicUrl),
                            height: 45,
                            width: 45,
                            fit: BoxFit.cover,
                          ))
                      : Text(
                          avatar,
                          style: GoogleFonts.mukta(
                              fontSize: 18.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              letterSpacing: 1.0),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.0,
                        )),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          (widget.contactData.displayName != null)
                              ? widget.contactData.displayName
                              : "No Name",
                          style: GoogleFonts.notoSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: qbAppTextColor),
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.0,
                        ),
                      ),
                      SizedBox(
                        height: 2.5,
                      ),
                      Container(
                        child: Text(
                          "$dialCode ${widget.contactData.phoneNumber}",
                          style: GoogleFonts.roboto(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: qbDetailLightColor),
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                  child: (widget.contactData.isAppUser)
                      ? WrapButton(
                          child: Text(
                            "Request",
                            style: GoogleFonts.roboto(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                            textScaleFactor: 1.0,
                          ),
                          width: 75,
                          borderRadius: BorderRadius.circular(3.5),
                          color: qbAppPrimaryGreenColor,
                          padding: EdgeInsets.symmetric(
                              vertical: 6.5, horizontal: 13.5),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return RequestPayment(
                                  contactData: widget.contactData,
                                  amount: widget.amount,
                                );
                              },
                            ));
                          },
                        )
                      : WrapButton(
                          child: Text(
                            "Invite",
                            style: GoogleFonts.roboto(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                            textScaleFactor: 1.0,
                          ),
                          width: 75,
                          borderRadius: BorderRadius.circular(3.5),
                          color: qbAppPrimaryBlueColor,
                          padding: EdgeInsets.symmetric(
                              vertical: 6.5, horizontal: 13.5),
                          onPressed: () {},
                        ))
            ],
          ),
        ],
      ),
    );
  }
}
