import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Pages/Profile/ProfileEdit/ProfileEdit.dart';
import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    loadHandler(bool status) {
      setState(() {
        isLoading = status;
      });
    }

    return Container(
      child: Stack(
        children: [
          ProfileEdit(
            changeLoadStatus: loadHandler,
          ),

          // Loader Page
          (isLoading)
              ? LoaderPage()
              : Container(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }
}
