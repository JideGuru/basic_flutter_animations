import 'package:basic_animations/paint/paint.dart';
import 'package:basic_animations/paint/pepsi_talk.dart';
import 'package:basic_animations/pepsi/pepsi.dart';
import 'package:basic_animations/sharingan/sharingan.dart';
import 'package:basic_animations/sharingan/tomoe.dart';
import 'package:flutter/material.dart';

import 'talent_match/talent_match.dart';

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
      home: SharinganLoader(),
      // home: TalentMatch(),
      debugShowCheckedModeBanner: false,
    );
  }
}
