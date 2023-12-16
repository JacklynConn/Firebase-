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
      child: Column(
        children: [
          Expanded(child: _buildStreamBuilder),
          _buildMessageTextField,
          SizedBox(height: 20),
        ],
      ),
    );
  }

  TextEditingController _texCtrl = TextEditingController();

  Widget get _buildMessageTextField {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _texCtrl,
              decoration: InputDecoration(
                hintText: "Say something...",
              ),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                MessageModel record = MessageModel(text: _texCtrl.text.trim(),
                  date: DateTime.now().toIso8601String(),);

                _messageHelper.insertRecord(record);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildStreamBuilder {
    return Container(
      color: Colors.grey[200],
      alignment: Alignment.center,
      child: StreamBuilder<QuerySnapshot>(
        stream: _messageHelper.read(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("${snapshot.error}");
            return Text("${snapshot.error}");
          } else {
            if (snapshot.hasData)
              return _buildListView(snapshot.data!.docs);
            else
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildListView(List<DocumentSnapshot> documents) {
    List<MessageModel> recordList =
    documents.map((data) => MessageModel.fromSnapshot(data)).toList();
    return ListView.builder(
      reverse: true,
      itemCount: recordList.length,
      itemBuilder: (context, index) {
        return _buildListViewItem(recordList[index]);
      },
    );
  }

  Widget _buildListViewItem(MessageModel item) {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 5, 10, 5),
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListTile(
        title: Text("${item.text}"),
        subtitle: Text("${item.date}"),
      ),
    );
  }
}

