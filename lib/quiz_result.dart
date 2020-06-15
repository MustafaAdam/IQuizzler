import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final List<bool> _userFinalAnswers;

  Result(this._userFinalAnswers, {Key key}) : super(key: key);

  final TextStyle style =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50);

  int finalScore() {
    int totalCorrect = -1;
    _userFinalAnswers.forEach((element) {
      if (element == true) totalCorrect++;
    });
    // return (totalCorrect / _userFinalAnswers.length * 100);
    return totalCorrect;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.red.withOpacity(0.7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            // 'Your percentage is: ${finalScore()}%',
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
                // Navigator.of(context).popUntil(ModalRoute.withName('landing_page'));
                // Navigator.of(context).popUntil(ModalRoute.withName(Navigator.defaultRouteName));
                int popCounter = 0;
                Navigator.of(context).popUntil((route) {
                  return popCounter++ == 2;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
