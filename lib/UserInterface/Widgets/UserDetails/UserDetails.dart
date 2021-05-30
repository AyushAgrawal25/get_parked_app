import 'package:fluttericon/font_awesome5_icons.dart';

import './UserDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDetailsWidget extends StatefulWidget {
  
  Map details;
  
  UserDetailsWidget({
    this.details
  });

  @override
  _UserDetailsWidgetState createState() => _UserDetailsWidgetState();
}

class _UserDetailsWidgetState extends State<UserDetailsWidget> {
  var qbDetailWidgetList=<Widget>[];

  @override
  Widget build(BuildContext context) {
    qbDetailWidgetList=[];
    //For Name
    if(widget.details['name']!=null)
    {
      qbDetailWidgetList.add(
        Container(
          child: Text(
            widget.details['name'],
            style: GoogleFonts.mukta(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
            textScaleFactor: 1,
          ),
        ),
      );

      qbDetailWidgetList.add(
        SizedBox(
          height: 5,
        ),
      );
    }

    //For Email
    if(widget.details['email']!=null)
    {
      qbDetailWidgetList.add(
        UserDetailWidget(
          iconName: FontAwesomeIcons.envelope,
          detail: widget.details['email'],
        ),
      );
    }
    
    //For dob
    if(widget.details['dob']!=null)
    {
      qbDetailWidgetList.add(
        UserDetailWidget(
          iconName: FontAwesomeIcons.calendar,
          detail: widget.details['dob'],
          isEditable: true,
        ),
      );
    }

    //For UpiId
    if(widget.details['upiId']!=null)
    {
      qbDetailWidgetList.add(
        UserDetailWidget(
          iconName: FontAwesome5.wallet,
          detail: widget.details['upiId'],
        ),
      );
    }
    
    //For number
    if(widget.details['number']!=null)
    {
      qbDetailWidgetList.add(
        UserDetailWidget(
          iconName: FontAwesomeIcons.phone,
          detail: widget.details['number'],
          isEditable: true,
        ),
      );
    }

    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Column(
        children: qbDetailWidgetList
      ),
    );
  }
}