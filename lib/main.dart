import 'package:flutter/material.dart';

import "package:flutter_sqlite1/screen/home_screen.dart";
import "package:flutter_sqlite1/screen/insert_screen.dart";

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Colors.amberAccent,
        fontFamily: "Georgia",
        textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            headline2: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: Colors.red,
            ),
            headline3: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ))),
    home: HomePage(),
    routes: {
      InsertScreen.routeName: (context) => const InsertScreen(),
      HomePage.routeName: (context) => const HomePage()
    },
    onUnknownRoute: (settings) => MaterialPageRoute(
      builder: (context) => const Text('Unknown route'),
    ),
  ));
}
