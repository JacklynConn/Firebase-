import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody,
      floatingActionButton: _buildFloatingActionButton,
    );
  }

  AppBar get _buildAppBar {
    return AppBar(
      title: Text("Main Page"),
    );
  }

  Widget get _buildBody {
    return Center(
      child: Text("Main Page"),
    );
  }

  FloatingActionButton get _buildFloatingActionButton {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.add),
    );
  }
}
