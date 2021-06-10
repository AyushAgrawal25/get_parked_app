import 'dart:io';

import 'package:getparked/BussinessLogic/ParkingLordServices.dart';
import 'package:getparked/StateManagement/Models/ParkingLordData.dart';
import 'package:getparked/StateManagement/Models/SlotImageData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/UserInterface/Widgets/ImagePicker/ImagePickerAndInserter.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class SlotImgGallery extends StatefulWidget {
  int focusIndex;

  SlotImgGallery({this.focusIndex: 0});
  @override
  _SlotImgGalleryState createState() => _SlotImgGalleryState();
}

class _SlotImgGalleryState extends State<SlotImgGallery> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gpAppState = Provider.of<AppState>(context, listen: false);
    pageController = PageController(initialPage: widget.focusIndex);
    // pageController.jumpToPage(widget.focusIndex);
  }

  PageController pageController;
  AppState gpAppState;
  List<SlotImageData> slotImages = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AppState gpAppStateListen = Provider.of<AppState>(context);
    slotImages = gpAppStateListen.parkingLordData.images;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Typicons.picture,
              size: 17.5,
              color: qbWhiteBGColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Gallery",
              style: GoogleFonts.nunito(
                  color: qbWhiteBGColor, fontWeight: FontWeight.w600),
              textScaleFactor: 1.0,
            ),
          ],
        ),
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.1),
        // elevation: 0.0,
        iconTheme: IconThemeData(color: qbWhiteBGColor),
        brightness: Brightness.dark,
        actions: [
          IconButton(
            icon: Icon(
              FontAwesome.pencil,
              size: 17.5,
              color: qbWhiteBGColor,
            ),
            onPressed: onEditImage,
          ),
          IconButton(
            icon: Icon(
              FontAwesome.trash,
              size: 17.5,
              color: qbWhiteBGColor,
            ),
            onPressed: onDeleteImg,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            child: PhotoViewGallery.builder(
              pageController: pageController,
              itemCount: slotImages.length,
              builder: (context, index) {
                String imgUrl = formatImgUrl(slotImages[index].imageUrl);
                return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(imgUrl));
              },
              loadingBuilder: (context, event) => Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                ),
              ),
            ),
          ),

          // Loader
          (isLoading)
              ? Container(
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }

  onEditImage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ImagePickerAndInserter(
          imgUrl:
              formatImgUrl(slotImages[pageController.page.toInt()].imageUrl),
          onImageInsert: onImageInsert,
          cropRatioX: 4,
          cropRatioY: 3,
        );
      },
    ));
  }

  onImageInsert(File newImgFile) async {
    if (newImgFile != null) {
      setState(() {
        isLoading = true;
      });

      SlotImageUpdateStatus imageUpdateStatus = await ParkingLordServices()
          .updateSlotImage(
              type: SlotImageType.other,
              imgFile: newImgFile,
              slotImageId: gpAppState
                  .parkingLordData.images[pageController.page.toInt()].id,
              authToken: gpAppState.authToken);
      if (imageUpdateStatus == SlotImageUpdateStatus.successful) {
        await ParkingLordServices().getParkingLord(context: context);
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  onDeleteImg() async {
    // TODO: create this function.
    setState(() {
      isLoading = true;
    });
    SlotImageDeleteStatus imageDeleteStatus = await ParkingLordServices()
        .deleteSlotImage(
            authToken: gpAppState.authToken,
            slotImageId: slotImages[pageController.page.toInt()].id);
    if (imageDeleteStatus == SlotImageDeleteStatus.successful) {
      if (pageController.page.toInt() == 0) {
        if (slotImages.length == 1) {
          Navigator.of(context).pop();
        }
      } else {
        pageController.jumpToPage(pageController.page.toInt() - 1);
      }
      await ParkingLordServices().getParkingLord(context: context);
    }

    setState(() {
      isLoading = false;
    });
  }
}
