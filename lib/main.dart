import 'package:basic_animations/pepsi/pepsi.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // brightness: Brightness.dark
      ),
      // debugShowMaterialGrid: true,
      home: Pepsi(),
      debugShowCheckedModeBanner: false,
    );
  }
}
