import 'package:getparked/StateManagement/Models/ContactData.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUtils {
  Future makeCall(String phNum) async {
    String url = "tel:" + phNum;
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print("Exception Found While Calling $phNum");
      }
    } catch (excep) {
      print("Exception Found While Calling $phNum");
    }
  }

  List<ContactData> distinctPhoneNumbers(List<ContactData> contacts) {
    List<ContactData> gpContacts = [];
    contacts.forEach((contact) {
      int index = 0;
      int targetIndex;
      bool isContactAlreadyPresent = false;

      // Checking Is This Phone Number Already Present
      gpContacts.forEach((gpContact) {
        if (gpContact.phoneNumber == contact.phoneNumber) {
          isContactAlreadyPresent = true;
          targetIndex = index;
        }
        index++;
      });

      if (!isContactAlreadyPresent) {
        gpContacts.add(contact);
      } else {
        if (!gpContacts[targetIndex].isAppUser) {
          gpContacts[targetIndex] = contact;
        }
      }
    });

    return gpContacts;
  }

  List<ContactData> sort(List<ContactData> contacts) {
    List<ContactData> gpContacts = contacts;
    gpContacts.sort((a, b) => a.displayName.compareTo(b.displayName));
    return gpContacts;
  }

  static String encodePhNum(String phNum) {
    String enPhNum = "";
    for (int i = 0; i < phNum.length; i++) {
      if (i < phNum.length - 3) {
        enPhNum += "x";
      } else {
        enPhNum += phNum[i];
      }
    }

    return enPhNum;
  }
}
