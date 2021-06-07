import 'package:getparked/UserInterface/Pages/ParkingLord/ParkingLordEdit/ParkingLordEdit.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:flutter/material.dart';

class ParkingLordEditPage extends StatefulWidget {
  @override
  _ParkingLordEditPageState createState() => _ParkingLordEditPageState();
}

class _ParkingLordEditPageState extends State<ParkingLordEditPage> {
  bool isLoading = false;
  loadHandler(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          // Edit Page
          ParkingLordEdit(
            changeLoadStatus: loadHandler,
          ),

          // Loader
          (isLoading)
              ? Container(
                  child: LoaderPage(),
                )
              : Container(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }
}
