import 'package:dotcom_mart/screen/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "dotcommersse",
      theme: ThemeData(
        primaryColor: Color(0xFF12BD12),
        accentColor: Color(0xFF12BD12),
      ),
      home: MainScreen(),
    );
  }
}
