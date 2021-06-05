import 'package:flutter/cupertino.dart';
import 'package:getparked/UserInterface/Pages/Profile/Profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [Profile()],
      ),
    );
  }
}
