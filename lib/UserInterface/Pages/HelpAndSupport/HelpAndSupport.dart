import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:getparked/BussinessLogic/FAQsServices.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/FAQData.dart';
import 'package:getparked/UserInterface/Pages/HelpAndSupport/FAQWidgets/FAQWidget.dart';
import 'package:getparked/UserInterface/Pages/HelpAndSupport/HelpAndSupportPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HelpAndSupport extends StatefulWidget {
  @override
  _HelpAndSupportState createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  @override
  void initState() {
    super.initState();

    initFAQs();
  }

  bool isLoading = false;
  List<FAQData> faqs = [];
  AppState gpAppState;
  initFAQs() async {
    setState(() {
      isLoading = true;
    });
    gpAppState = Provider.of<AppState>(context, listen: false);
    faqs = await FAQsServices().getFaqs(authToken: gpAppState.authToken);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Icon(
              FontAwesome.comment,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Help And Support",
              style: GoogleFonts.nunito(
                  color: Colors.white, fontWeight: FontWeight.w500),
              textScaleFactor: 1.0,
            ),
          ]),
          brightness: Brightness.dark,
          backgroundColor: qbAppPrimaryThemeColor,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ListView.builder(
                itemCount: faqs.length,
                itemBuilder: (context, index) {
                  return FAQWidget(
                    faqData: faqs[index],
                  );
                },
              ),
            ),
            (isLoading)
                ? LoaderPage()
                : Container(
                    height: 0,
                    width: 0,
                  )
          ],
        ),
      ),
    );
  }
}
