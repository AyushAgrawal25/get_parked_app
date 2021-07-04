import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getparked/BussinessLogic/UserServices.dart';
import 'package:getparked/StateManagement/Models/FAQData.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/Utils/JSONUtils.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:http/http.dart' as http;

const FAQS_ROUTE = "/app/queries/faqs";

class FAQsServices {
  Future<List<FAQData>> getFaqs({@required String authToken}) async {
    try {
      Uri url = Uri.parse(domainName + FAQS_ROUTE);
      http.Response resp = await http.get(url, headers: {
        AUTH_TOKEN: authToken,
        CONTENT_TYPE_KEY: JSON_CONTENT_VALUE
      });

      if (resp.statusCode == 200) {
        Map respBody = json.decode(resp.body);
        List faqMaps = respBody["data"];
        List<FAQData> faqs = [];
        faqMaps.forEach((faqMap) {
          faqs.add(FAQData.fromMap(faqMap));
        });

        return faqs;
      } else if (resp.statusCode == 403) {
        return [];
      } else if (resp.statusCode == 500) {
        return [];
      }
      return [];
    } catch (excp) {
      print(excp);
      return [];
    }
  }

  Future<FAQUpVoteStatus> upVote(
      {@required String authToken, @required int faqId}) async {
    try {
      Map<String, dynamic> reqBody = {"faqId": faqId};
      Uri url = Uri.parse(domainName + FAQS_ROUTE + "/upvote");
      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            AUTH_TOKEN: authToken,
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE
          });

      print(resp.body);
      if (resp.statusCode == 200) {
        return FAQUpVoteStatus.successful;
      } else if (resp.statusCode == 403) {
        return FAQUpVoteStatus.invalidToken;
      } else if (resp.statusCode == 500) {
        return FAQUpVoteStatus.internalServerError;
      }
      return FAQUpVoteStatus.failed;
    } catch (excp) {
      print(excp);
      return FAQUpVoteStatus.failed;
    }
  }
}

enum FAQUpVoteStatus { successful, failed, invalidToken, internalServerError }
