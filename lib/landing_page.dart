import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

import 'quiz.dart';

class LandingPage extends StatefulWidget {

  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int numberOfQuestions = 1;
  String difficulty;

  final TextStyle style = GoogleFonts.vollkorn(
    color: Colors.black,
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.amber.shade400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Choose the number of questions: ",
            style: style,
            textAlign: TextAlign.center,
          ),
          NumberPicker.integer(
            initialValue: numberOfQuestions,
            minValue: 1,
            maxValue: 50,
            onChanged: (number) { 
              setState(() {
                this.numberOfQuestions = number;
              });
            },
            itemExtent: 90,
            scrollDirection: Axis.vertical,
          ),
          SizedBox(height: 40,),
          Text(
            "Choose the difficulty: ",
            style: style,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          DropdownButton(
            elevation: 12,
            dropdownColor: Colors.blue,
            hint: Text('Difficulty'),
            icon: Icon(Icons.arrow_drop_down_circle),
            value: difficulty,
            style: style,
            items: [
              DropdownMenuItem(
                child: Text("Easy", style: style),
                onTap: () => setState(() {this.difficulty = 'easy';}),
                value: 'easy',
              ),
              DropdownMenuItem(
                child: Text("Medium", style: style),
                onTap: () => setState(() {this.difficulty = 'medium';}),
                value: 'medium',
              ),
              DropdownMenuItem(
                child: Text("Hard", style: style),
                onTap: () => setState(() {this.difficulty = 'hard';}),
                value: 'hard',
              ),
            ],
            onChanged: (choice) {
              setState(() {
                this.difficulty = choice;
                print(this.numberOfQuestions);
                Navigator.of(context).push(
                  MaterialPageRoute(builder:
                    (context) => Quiz(this.numberOfQuestions, this.difficulty)
                  )
                );
              });
            },
          ),
          // FlatButton(
          //   onPressed: () => print("OKKK"),
          //   child: Icon(Icons.arrow_forward_ios, color: Colors.amber),
          //   color: Colors.black,
          // ),
        ],
      ),
    );
  }
}
