import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_model.dart';

class MessageHelper {
  final String _colName = MessageModel.collectionName;

  Stream<QuerySnapshot<Map<String, dynamic>>> read() {
    return FirebaseFirestore.instance
        .collection(_colName)
        .orderBy(MessageModel.dateString, descending: true)
        .snapshots();
  }

  Future insertRecord(MessageModel record) {
    return FirebaseFirestore.instance.runTransaction((trx) async {
      CollectionReference colRef =
          FirebaseFirestore.instance.collection(_colName);
      await colRef.add(record.toMap);
    }).then((x) => print("inserted"));
  }
}
