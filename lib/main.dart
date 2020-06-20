import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import './landing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  .then( (_){
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IQuizzler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline5: GoogleFonts.volkhov(color: Colors.red, fontSize: 55, fontWeight: FontWeight.bold),
          bodyText2: GoogleFonts.vollkorn(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w600),
          headline1: TextStyle(color: Colors.red, ),
          headline2: TextStyle(color: Colors.red, ),
          headline3: TextStyle(color: Colors.red, ),
          headline4: TextStyle(color: Colors.red, ),
          headline6: TextStyle(color: Colors.red, ),
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
