import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'result_page.dart';
import 'api_calls.dart';
import 'model.dart';


final TextStyle style = GoogleFonts.vollkorn(
  color: Colors.amberAccent,
  fontSize: 25,
  fontWeight: FontWeight.w100,
);

class Quiz extends StatefulWidget {
  final int numberOfQuestions;
  final String difficulty;
  final int category;

  Quiz(this.numberOfQuestions, this.difficulty, this.category,
          {Key key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}


class _QuizState extends State<Quiz> {

  Future<List<Results>> trivia;

  @override
  void initState() {
    print('Difficulty: ' + widget.difficulty);
    print('Category: ' + widget.category.toString());
    print('Number of Questions: ' + widget.numberOfQuestions.toString());

    trivia = fetchTrivia('https://opentdb.com/api.php?amount=${widget.numberOfQuestions}&category=${widget.category}&difficulty=${widget.difficulty}&type=boolean');
    print('https://opentdb.com/api.php?amount=${widget.numberOfQuestions}&category=${widget.category}&difficulty=${widget.difficulty}&type=boolean');
    getQuestionsAndAnswers();
    super.initState();
  }

  void getQuestionsAndAnswers() {
    trivia.then((data) {
      data.forEach((element) {
        questions.add(element.getQuestion
                             .replaceAll('&quot;', '"')
                             .replaceAll('&#039;', "'")
                             .replaceAll('&eacute;', 'e')
                             .replaceAll('&deg;C', 'Celsius')
                             .replaceAll('&deg;F', 'Fahrenheit')
                             .replaceAll('&ocirc;', 'o'));
        correctAnswers.add(element.getCorrectAnswer.toLowerCase());
        category.add(element.getCategory);
        difficulties.add(element.difficulty);
      });
    }).catchError((onError) {  // ? Catch the exceptions from f
      print(onError);
    });
  }

  List<String> questions = ["Fetching questions ..."];
  List<String> correctAnswers = ['True'];
  List<String> category = [''];
  List<String> difficulties = [''];
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
      color: Colors.blue.withOpacity(0.2),
      child: SafeArea(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                category[currentIndex],
                style: style.copyWith(color: Colors.white),
                textAlign: TextAlign.center,),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                difficulties[currentIndex],
                style: style.copyWith(color: Colors.white54),
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


            this.currentIndex == 0 ? FutureBuilder(
              future: Future.delayed(Duration(seconds: 1)),
              builder: (_, snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [Colors.amber,Colors.green, Colors.white],
                          radius: 0.7,
                        ),
                      ),
                      height: 50, width: 50,
                        // color: Colors.black,
                        child: FlatButton(
                          onPressed: () {
                            checkAnswer(true);
                          },
                          child: Text(
                            "Go!",
                            style: style.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 60),
                          ),
                        )
                    )
                  );
                }
                return Container(
                  height: 200, width: 1,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amberAccent),
                    strokeWidth: 4.0,
                  ),
                );
              },
            ) : Expanded(
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
                        )
                    )
                  ),


            this.currentIndex == 0 ? Container() : Expanded(
                flex: 1,
                child: Container(
                    color: Colors.red.withOpacity(0.7),
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
