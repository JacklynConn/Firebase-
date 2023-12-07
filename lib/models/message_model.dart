class MessageModel {

  static const String collectionName = "chat";
  static const String textString = "text";
  static const String dateString = "date";
  String text;
  String date;

  MessageModel({
    this.text = "no text",
    this.date = "no date",
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      text: map[textString],
      date: map[dateString],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      textString: text,
      dateString: date,
    };
  }
}
