import 'dart:convert';

class JSONUtils {
  String postBody(Map<String, dynamic> body) {
    return jsonEncode(body);
  }
}
