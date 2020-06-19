import 'package:http/http.dart' as http;
import 'dart:convert';
import 'trivia.dart';


// Future<List<Results>> fetchTrivia() async {
//   var url = 'https://opentdb.com/api.php?amount=5&difficulty=easy&type=boolean';
//   final http.Response response = await http.get(url);

//   if(response.statusCode == 200) {
//     var answer = json.decode(response.body);
//     return Question.fromJson(answer).results;
//   }
//   else
//     throw Exception('Failure to launch');
// }

Future<List<Results>> fetchTrivia(String url) async {
  final http.Response response = await http.get(url);

  if(response.statusCode == 200) {
    var answer = json.decode(response.body);
    return Question.fromJson(answer).results;
  }
  else {
    throw Exception('Failure to launch');
  }
}