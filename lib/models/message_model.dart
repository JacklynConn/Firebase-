import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {

  static const String collectionName = "chat";
  static const String textString = "text";
  static const String dateString = "date";

  late String text;
  late String date;
  DocumentReference reference;


  MessageModel({
    this.text = "no text",
    this.date = "no date",
    required this.reference,
  });

  MessageModel.fromMap(Object? object, {required this.reference}) {
    Map<String, dynamic> map = object as Map<String, dynamic>;
    text = (map ?? {}) [textString] ?? "no text";
    date = (map ?? {}) [dateString] ?? 0;

  }
  MessageModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);

  Map<String, dynamic> toMap() {
    return {
      textString: text,
      dateString: date,
    };
  }
}
