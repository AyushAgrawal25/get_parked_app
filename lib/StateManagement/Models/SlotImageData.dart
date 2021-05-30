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
      if (slotImageMap["slotImageId"] != null) {
        id = slotImageMap["slotImageId"];
      }

      // Image Type
      if (slotImageMap["slotImageType"] != null) {
        if (slotImageMap["slotImageType"] == 0) {
          type = SlotImageType.main;
        } else {
          type = SlotImageType.other;
        }
      }

      // Image Url
      if (slotImageMap["slotImageUrl"] != null) {
        imageUrl = slotImageMap["slotImageUrl"];
      }

      // Thumbnail Image Url
      if (slotImageMap["slotImageThumbnailUrl"] != null) {
        thumbnailUrl = slotImageMap["slotImageThumbnailUrl"];
      }

      // Status
      if (slotImageMap["slotImageStatus"] != null) {
        status = slotImageMap["slotImageStatus"];
      }
    }
  }
}

enum SlotImageType { main, other }
