import 'package:firebase5/pages/main_page.dart';
import 'package:firebase5/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Error: ${snapshot.error}");
          return _buildMaterial(
            const Scaffold(
              body: Center(
                child: Text("Error Firebase"),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildMaterial(const MainPage());
        } else {
          return _buildMaterial(const Center(
            child: Scaffold(
              body: CircularProgressIndicator(),
            ),
          ));
        }
      },
    );
  }

  _buildMaterial(Widget home) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
