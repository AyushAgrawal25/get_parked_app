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

  List<ContactData> distinctDisplayName(List<ContactData> contacts) {
    List<ContactData> gpContacts = [];
    contacts.forEach((contact) {
      int index = 0;
      int targetIndex;
      bool isContactAlreadyPresent = false;
      // Checking Is This Phone Number Already Present
      gpContacts.forEach((gpContact) {
        if (gpContact.displayName == contact.displayName) {
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

  List<ContactData> search(List<ContactData> contacts, String gpSearchText) {
    List<ContactData> gpContacts = contacts;
    for (int i = 0; i < gpSearchText.length; i++) {
      gpContacts = this.findInContacts(gpContacts, gpSearchText[i], i);
    }

    return gpContacts;
  }

  List<ContactData> findInContacts(
      List<ContactData> contacts, String letterOrNumber, int position) {
    List<ContactData> gpContactsSearched = [];
    List<ContactData> gpContactsSearchedByLetter =
        this.findInContactsByLetter(contacts, letterOrNumber, position);
    List<ContactData> gpContactsSearchedByNumber =
        this.findInContactsByNumber(contacts, letterOrNumber, position);

    gpContactsSearchedByLetter.forEach((gpContactSearchedByLetter) {
      bool isContactAlreadyPresent = false;
      gpContactsSearched.forEach((gpContactSearched) {
        if (gpContactSearched.phoneNumber ==
            gpContactSearchedByLetter.phoneNumber) {
          isContactAlreadyPresent = true;
        }
      });
      if (!isContactAlreadyPresent) {
        gpContactsSearched.add(gpContactSearchedByLetter);
      }
    });

    gpContactsSearchedByNumber.forEach((gpContactSearchedByNumber) {
      bool isContactAlreadyPresent = false;
      gpContactsSearched.forEach((gpContactSearched) {
        if (gpContactSearched.phoneNumber ==
            gpContactSearchedByNumber.phoneNumber) {
          isContactAlreadyPresent = true;
        }
      });
      if (!isContactAlreadyPresent) {
        gpContactsSearched.add(gpContactSearchedByNumber);
      }
    });

    return gpContactsSearched;
  }

  List<ContactData> findInContactsByLetter(
      List<ContactData> contacts, String letter, int position) {
    List<ContactData> gpContactsByLetter = [];
    int maxLength = 0;
    contacts.forEach((contact) {
      if (maxLength < contact.displayName.length) {
        maxLength = contact.displayName.length;
      }
    });

    for (int i = position; i < maxLength; i++) {
      contacts.forEach((contact) {
        if (contact.displayName.length > i) {
          if (contact.displayName[i].toLowerCase() == letter.toLowerCase()) {
            // Checking Whether the contact is Already Present
            bool isContactAlreadyPresent = false;
            gpContactsByLetter.forEach((gpContact) {
              if (gpContact.phoneNumber == contact.phoneNumber) {
                isContactAlreadyPresent = true;
              }
            });
            if (!isContactAlreadyPresent) {
              gpContactsByLetter.add(contact);
            }
          }
        }
      });
    }

    return gpContactsByLetter;
  }

  List<ContactData> findInContactsByNumber(
      List<ContactData> contacts, String number, int position) {
    List<ContactData> gpContactsByNumber = [];
    int maxLength = 0;
    contacts.forEach((contact) {
      if (maxLength < contact.phoneNumber.length) {
        maxLength = contact.phoneNumber.length;
      }
    });

    for (int i = position; i < maxLength; i++) {
      contacts.forEach((contact) {
        if (contact.phoneNumber.length > i) {
          if (contact.phoneNumber[i].toLowerCase() == number.toLowerCase()) {
            // Checking Whether the contact is Already Present
            bool isContactAlreadyPresent = false;
            gpContactsByNumber.forEach((gpContact) {
              if (gpContact.phoneNumber == contact.phoneNumber) {
                isContactAlreadyPresent = true;
              }
            });
            if (!isContactAlreadyPresent) {
              gpContactsByNumber.add(contact);
            }
          }
        }
      });
    }

    return gpContactsByNumber;
  }
}
