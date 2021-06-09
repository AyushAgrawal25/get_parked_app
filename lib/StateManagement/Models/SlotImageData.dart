class SlotImageData {
  int id;
  SlotImageType type;
  String imageUrl;
  String thumbnailUrl;
  Map data;
  int status;

  SlotImageData.fromMap(Map slotImageMap) {
    if (slotImageMap != null) {
      // Complete Data
      data = slotImageMap;

      // Slot Image Id
      if (slotImageMap["id"] != null) {
        id = slotImageMap["id"];
      }

      // Image Type
      if (slotImageMap["type"] != null) {
        if (slotImageMap["type"] == "Main") {
          type = SlotImageType.main;
        } else {
          type = SlotImageType.other;
        }
      }

      // Image Url
      if (slotImageMap["url"] != null) {
        imageUrl = slotImageMap["url"];
      }

      // Thumbnail Image Url
      if (slotImageMap["thumbnailUrl"] != null) {
        thumbnailUrl = slotImageMap["thumbnailUrl"];
      }

      // Status
      if (slotImageMap["status"] != null) {
        status = slotImageMap["status"];
      }
    }
  }
}

enum SlotImageType { main, other }
