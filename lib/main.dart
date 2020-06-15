import 'package:flutter/material.dart';
import './landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline5: TextStyle(color: Colors.red, fontSize: 60, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
        ),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        'landing_page': (context) => LandingPage(),
      },
      home: LandingPage(),
      );
  }
}
