import 'package:flutter/material.dart';
import 'package:testing_http_package/trivia.dart';
import 'package:google_fonts/google_fonts.dart';

import 'quiz_result.dart';
import 'api_calls.dart';

class Quiz extends StatefulWidget {
  final int numberOfQuestions;
  final String difficulty;
  Quiz(this.numberOfQuestions, this.difficulty,
          {Key key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {

  Future<List<Results>> trivia;

  final TextStyle style = GoogleFonts.vollkorn(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );

  @override
  void initState() {
    trivia = fetchTrivia('https://opentdb.com/api.php?amount=${widget.numberOfQuestions}&difficulty=easy&type=boolean'
    );
    getQuestionsAndAnswers();
    // Future.delayed(Duration(seconds: 1), () {print("HA");});
    super.initState();
  }

  void getQuestionsAndAnswers() {
    trivia.then((data) {
      data.forEach((element) {
        questions.add(element.getQuestion
                             .replaceAll('&quot;', '"')
                             .replaceAll('&#039;', "'")
                             .replaceAll('&eacute;', 'e'));
        correctAnswers.add(element.getCorrectAnswer.toLowerCase());
        category.add(element.getCategory);
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  List<String> questions = ["Are you ready?"];
  List<String> correctAnswers = ['True'];
  List<String> category = [''];
  List<bool> finalAnswers = [];

  int currentIndex = 0;

  void checkAnswer(bool userAnswer) {
    bool answer =
        correctAnswers[currentIndex].toLowerCase() == userAnswer.toString();
    if (answer == true) {
      finalAnswers.add(true);
    } else {
      finalAnswers.add(false);
    }

    this.currentIndex++;

    if(this.currentIndex == questions.length) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Result(this.finalAnswers)),
      );
    }
    else setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.3),
      child: SafeArea(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                category[currentIndex],
                style: style,
                textAlign: TextAlign.center,),
            ),
            Expanded(
              flex: 6,
              child: Center(
                child: Text(
                  questions[currentIndex],
                  style: style,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                    color: Colors.green,
                    child: FlatButton(
                      onPressed: () {
                        checkAnswer(true);
                      },
                      child: Text(
                        "True",
                        style: style.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ))),
            Expanded(
                flex: 1,
                child: Container(
                    color: Colors.red,
                    child: FlatButton(
                      onPressed: () {
                        checkAnswer(false);
                      },
                      child: Text("False",
                          style: style.copyWith(color: Colors.black, fontWeight: FontWeight.bold)
                    )
                    )
                ),
            )
          ],
        ),
      ),
    );
  }
}
