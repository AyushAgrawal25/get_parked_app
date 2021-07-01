import 'package:flutter/cupertino.dart';
import 'package:getparked/BussinessLogic/UserServices.dart';
import 'package:getparked/StateManagement/Models/ContactData.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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

  List<ContactData> search(List<ContactData> contacts, String gpSearchText) {
    Iterable<ContactData> contaccts = contacts.where((contactData) {
      return contactData
          .getSearchDetails()
          .toLowerCase()
          .contains(gpSearchText.toLowerCase());
    });

    return contaccts.toList();
  }

  Future<List<ContactData>> init({@required String authToken}) async {
    if (await Permission.contacts.request().isGranted) {
      Map<String, ContactData> contactsStore = {};

      Iterable<Contact> fetchedContacts =
          await ContactsService.getContacts(withThumbnails: false);

      // Getting fetchedContacts from phone
      fetchedContacts.forEach((contact) {
        contact.phones.forEach((num) {
          if (num.value.length >= 10) {
            String phoneNumber = num.value.substring(num.value.length - 10);
            String dialCode;
            if (num.value.length > 10) {
              dialCode = num.value.substring(0, num.value.length - 10);
              if (dialCode == "0") {
                dialCode = null;
              }
            }

            ContactData contactData = ContactData(
              dialCode: dialCode,
              displayName: contact.displayName,
              gender: "male",
              isAppUser: false,
              phoneNumber: phoneNumber,
            );

            if (contactsStore[phoneNumber] != null) {
              if (contactData.dialCode == null) {
                contactsStore[phoneNumber].dialCode = contactData.dialCode;
              }
            } else {
              contactsStore[phoneNumber] = contactData;
            }
          }
        });
      });

      List<Map<String, dynamic>> parsedContacts = parseForAPI(contactsStore);
      List<ContactData> registeredContacts = await UserServices()
          .getContacts(authToken: authToken, contactsList: parsedContacts);
      registeredContacts.forEach((element) {
        contactsStore[element.phoneNumber] = element;
      });

      List<ContactData> contacts = [];
      contactsStore.forEach((key, value) {
        contacts.add(value);
      });

      return contacts;
    }

    return null;
  }

  List<Map<String, dynamic>> parseForAPI(
      Map<String, ContactData> contactsStore) {
    List<Map<String, dynamic>> parsedContacts = [];
    contactsStore.forEach((key, value) {
      if (value.dialCode == null) {
        parsedContacts.add({
          "userDetails": {"phoneNumber": value.phoneNumber}
        });
      } else {
        parsedContacts.add({
          "userDetails": {
            "AND": [
              {"phoneNumber": value.phoneNumber},
              {"dialCode": value.dialCode}
            ]
          }
        });
      }
    });

    return parsedContacts;
  }
}
