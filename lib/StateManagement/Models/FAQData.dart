class FAQData {
  int id;
  String answer;
  String query;
  String description;
  int status;

  List upvotes;

  FAQData.fromMap(Map faqMap) {
    if (faqMap != null) {
      id = faqMap["id"];
      answer = faqMap["answer"];
      query = faqMap["query"];
      description = faqMap["description"];
      status = faqMap["status"];

      upvotes = faqMap["upVotes"];
    }
  }

  bool isUserUpvoted(int userId) {
    bool isUpVoted = false;
    upvotes.forEach((element) {
      if (element["userId"] == userId) {
        isUpVoted = true;
      }
    });

    return isUpVoted;
  }
}
