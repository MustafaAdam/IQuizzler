class Question {
  int responseCode;
  List<Results> results = [];

  Question({this.responseCode, this.results});

  Question.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (responseCode == 0) {
      json['results'].forEach((v) {
        results.add(Results.fromJson(v));
      });
    }
  }

  List<Results> get questions => results;
}

class Results {
  String category;
  String type;
  String difficulty;
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;

  String get getQuestion => this.question;
  String get getCorrectAnswer  => this.correctAnswer;
  String get getCategory => this.category;
  
  Results(
      {this.category,
      this.type,
      this.difficulty,
      this.question,
      this.correctAnswer,
      this.incorrectAnswers});

  Results.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    type = json['type'];
    difficulty = json['difficulty'];
    question = json['question'];
    correctAnswer = json['correct_answer'];
    incorrectAnswers = json['incorrect_answers'].cast<String>();
  }
}
