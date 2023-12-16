import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase5/helpers/message_helper.dart';
import 'package:firebase5/models/message_model.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MessageHelper _messageHelper = MessageHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody,
    );
  }

  AppBar get _buildAppBar {
    return AppBar(
      title: Text("Main Page"),
    );
  }

  Widget get _buildBody {
    return Container(
      alignment: Alignment.center,
      child: _buildStreamBuilder,
    );
  }

  Widget get _buildStreamBuilder {
    return StreamBuilder<QuerySnapshot>(
      stream: _messageHelper.read(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Error: ${snapshot.error}");
          return Text("${snapshot.error}");
        } else {
          if (snapshot.hasData) {
            return _buildListView(snapshot.data!.docs);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }

  Widget _buildListView(List<DocumentSnapshot> documents) {
    List<MessageModel> recordList =
        documents.map((e) => MessageModel.fromSnapshot(e)).toList();
    return ListView.builder(
      itemCount: recordList.length,
      itemBuilder: (context, index) {
        return _buildListViewItem(recordList[index]);
      },
    );
  }

  Widget _buildListViewItem(MessageModel messageModel) {
    return ListTile(
      title: Text(messageModel.text),
      subtitle: Text(messageModel.date.toString()),
    );
  }
}
