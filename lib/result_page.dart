import 'package:flutter/material.dart';



final TextStyle style =
  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50);

class Result extends StatelessWidget {
  final List<bool> _userFinalAnswers;

  Result(this._userFinalAnswers, {Key key}) : super(key: key);

  int finalScore() {
    int totalCorrect = -1;
    _userFinalAnswers.forEach((element) {
      if (element == true) totalCorrect++;
    });
    return totalCorrect;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.red.withOpacity(0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You percentage is: ${finalScore()} / ${_userFinalAnswers.length-1}',
            style: style,
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.only(top: 100),
            child: MaterialButton(
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 80,
              ),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          )
        ],
      ),
    );
  }
}
