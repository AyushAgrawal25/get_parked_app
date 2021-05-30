class OldNotificationData {
  int id;
  String time;

  // notificationTypeMasterId
  int type;

  // notificationSenderUserId and notificationSenderType
  int senderId;
  int senderType;

  // Slot Data
  Map senderSlotData;

  // User Data
  Map senderUserData;

  // Parking Request
  Map slotParkingRequest;

  // Booking Data
  Map slotBooking;

  // Parking Data
  Map slotParking;

  // Real Transaction Data
  Map realTransactionData;

  // Transaction Request Data
  Map transactionRequestData;

  //Complete Data
  Map data;

  int status;

  OldNotificationData(
      {this.id,
      this.senderId,
      this.senderType,
      this.senderSlotData,
      this.time,
      this.type,
      this.senderUserData,
      this.slotParkingRequest,
      this.slotBooking,
      this.slotParking,
      this.realTransactionData,
      this.transactionRequestData,
      this.data,
      this.status});
}
