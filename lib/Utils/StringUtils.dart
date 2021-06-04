class StringUtils {
  static String trimStringTillPosition(String text, int position) {
    String trimmedText = "";
    if (text.length >= position) {
      for (int i = 0; i < position; i++) {
        trimmedText += text[i];
      }
    }

    return trimmedText;
  }

  static String trimBetween(String text, int startPosition, int endPosition) {
    String trimmedText = "";
    if (text.length > endPosition) {
      for (int i = startPosition; i <= endPosition; i++) {
        trimmedText += text[i];
      }
    }

    return trimmedText;
  }

  static String toFirstLetterUpperCase(String text) {
    String generatedText = "";
    List<String> parts = text.split(" ");
    parts.forEach((part) {
      for (int i = 0; i < part.length; i++) {
        if (i == 0) {
          generatedText += part[i].toUpperCase();
        } else {
          generatedText += part[i];
        }
      }
      if (part.length > 0) {
        generatedText += " ";
      }
    });

    return generatedText;
  }

  static String _abcd = "qertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
  static bool isPlaceAlphabetic(String placeName) {
    bool isAlpha = false;
    for (int i = 0; i < _abcd.length; i++) {
      if (placeName.contains(_abcd[i])) {
        isAlpha = true;
        break;
      }
    }

    return isAlpha;
  }
}
