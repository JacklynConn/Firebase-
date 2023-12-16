import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_model.dart';

class MessageHelper {

  Stream<QuerySnapshot<Map<String, dynamic>>> read(){
    return FirebaseFirestore.instance.collection(MessageModel.collectionName).snapshots();
  }
}