import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

import 'quiz_page.dart';
import './categories.dart';

final TextStyle style = GoogleFonts.vollkorn(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.w500,
);

List<DropdownMenuItem<String>> dropDownCatogry(List<String> names) {
  return names.map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value, style: style),
    );
  }).toList();
}

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int numberOfQuestions = 1;
  String difficulty;

  String currentCategory;
  List<String> names;
  List<int> ids;

  @override
  void initState() {
    super.initState();
    names = categoryNames();
    ids = categoryIds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Material(
            // color: Colors.deepPurple.withOpacity(1),
      // color: Colors.red.withOpacity(0.6),
            color: Colors.black87,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Choose the Category: ",
                  style: style,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 7,
                ),
                DropdownButton(
                  elevation: 12,
                  dropdownColor: Colors.black,
                  hint: Text(
                    'Category',
                    textAlign: TextAlign.center,
                    style: style,
                  ),
                  icon: Icon(Icons.arrow_drop_down_circle),
                  value: currentCategory,
                  style: style,
                  items: dropDownCatogry(this.names),
                  onChanged: (choice) {
                    setState(() {
                      this.currentCategory = choice;
                    });
                  },
                ),
                Text(
                  "Choose the number of questions: ",
                  style: style,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
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
                  itemExtent: 60,
                  scrollDirection: Axis.vertical,
                  listViewWidth: 100,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Choose the difficulty: ",
                  style: style,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButton(
                  elevation: 12,
                  dropdownColor: Colors.black,
                  hint: Text('Difficulty', style: style,),
                  icon: Icon(Icons.arrow_drop_down_circle),
                  value: difficulty,
                  style: style,
                  items: [
                    DropdownMenuItem(
                      child: Text("Easy", style: style),
                      onTap: () => setState(() {
                        this.difficulty = 'easy';
                      }),
                      value: 'easy',
                    ),
                    DropdownMenuItem(
                      child: Text("Medium", style: style),
                      onTap: () => setState(() {
                        this.difficulty = 'medium';
                      }),
                      value: 'medium',
                    ),
                    DropdownMenuItem(
                      child: Text("Hard", style: style),
                      onTap: () => setState(() {
                        this.difficulty = 'hard';
                      }),
                      value: 'hard',
                    ),
                  ],
                  onChanged: (choice) {
                    setState(() {
                      this.difficulty = choice;
                    });
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  margin: EdgeInsets.only(top: 40),
                  child: MaterialButton(
                    child: Icon(Icons.arrow_forward, size: 50, color: Colors.white,),
                    color: Colors.black,
                    onPressed: () {
                      if (this.currentCategory == null ||
                          this.difficulty == null) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                                'You did not choose difficulty or category')));
                        return;
                      }

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Quiz(
                              this.numberOfQuestions,
                              this.difficulty,
                              this.ids[this.names.indexWhere((element) =>
                                  element == this.currentCategory)]
                          ),
                        ),
                      ).then((_) => {
                        setState( () {} )
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
