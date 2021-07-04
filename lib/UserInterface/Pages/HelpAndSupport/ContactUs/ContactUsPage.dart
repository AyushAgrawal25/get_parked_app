import 'package:flutter/material.dart';
import 'package:getparked/BussinessLogic/QueryServies.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/SuccessAndFailure/SuccessAndFailurePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  String title = "";
  String description = "";

  bool isLoading = false;
  bool isFormValid = false;
  checkValidity() {
    isFormValid = true;
    if ((title == null) || (title == "")) {
      isFormValid = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkValidity();
    return Container(
      color: qbWhiteBGColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Ask Your Query.",
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w600, color: qbAppTextColor),
              textScaleFactor: 1.0,
            ),
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: qbAppTextColor),
            elevation: 0.0,
          ),
          body: Container(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title.
                        Container(
                          child: Text(
                            "Customer Support",
                            style: GoogleFonts.nunito(
                                fontSize: 25,
                                color: qbAppTextColor,
                                fontWeight: FontWeight.w600),
                            textScaleFactor: 1.0,
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        // Description
                        Container(
                          child: Text(
                            "You can directly contact us by filling this form. As soon as you fill the form your query will be registered and help center try to answer your query.",
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                color: qbDetailLightColor,
                                fontWeight: FontWeight.w400),
                            textScaleFactor: 1.0,
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        // Note
                        Container(
                          child: Text(
                            "Note : Any updates regarding your query will be delivered to you through your registered email id.",
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                color: qbDetailLightColor,
                                fontWeight: FontWeight.w400),
                            textScaleFactor: 1.0,
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        // Title
                        FormFieldHeader(
                          headerText: "Title",
                          fontSize: 17.5,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: TextField(
                            style: GoogleFonts.roboto(
                                fontSize: 17.5 /
                                    MediaQuery.of(context).textScaleFactor,
                                fontWeight: FontWeight.w400,
                                color: qbAppTextColor),
                            onChanged: (value) {
                              setState(() {
                                title = value;
                              });
                            },
                            // controller: gpReviewTextController,
                            maxLines: 1,
                            decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: qbAppTextColor),
                                  borderRadius: BorderRadius.circular(7.5)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.5, horizontal: 20),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        // Title
                        FormFieldHeader(
                          headerText: "Description",
                          fontSize: 17.5,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: TextField(
                            style: GoogleFonts.roboto(
                                fontSize: 17.5 /
                                    MediaQuery.of(context).textScaleFactor,
                                fontWeight: FontWeight.w400,
                                color: qbAppTextColor),
                            onChanged: (value) {
                              setState(() {
                                description = value;
                              });
                            },
                            // controller: gpReviewTextController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: qbAppTextColor),
                                  borderRadius: BorderRadius.circular(7.5)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.5, horizontal: 20),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 40,
                        ),

                        Container(
                          alignment: Alignment.centerRight,
                          child: EdgeLessButton(
                            color: (isFormValid)
                                ? qbAppPrimaryBlueColor
                                : qbDividerDarkColor,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 25),
                              child: Text(
                                "Submit",
                                style: GoogleFonts.nunito(
                                    fontSize: 17.5,
                                    fontWeight: FontWeight.w600,
                                    color: qbWhiteBGColor),
                                textScaleFactor: 1.0,
                              ),
                            ),
                            onPressed: onQuerySubmit,
                          ),
                        )
                      ],
                    ),
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
        ),
      ),
    );
  }

  onQuerySubmit() async {
    AppState appState = Provider.of<AppState>(context, listen: false);
    setState(() {
      isLoading = true;
    });

    QuerySendStatus sendStatus = await QueryServies().sendQuery(
        authToken: appState.authToken, title: title, description: description);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SuccessAndFailurePage(
          statusText: "Query Status",
          status: (sendStatus == QuerySendStatus.successful)
              ? SuccessAndFailureStatus.success
              : SuccessAndFailureStatus.failure,
          onButtonPressed: () {
            if (sendStatus == QuerySendStatus.successful) {
              Navigator.of(context).pop();
            }
            Navigator.of(context).pop();
          },
        );
      },
    ));
    setState(() {
      isLoading = false;
    });
  }
}
