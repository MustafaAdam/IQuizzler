import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';


Future<List<Results>> fetchTrivia(String url) async {
  final http.Response response = await http.get(url);

  if (response.statusCode == 200) {
    var answer = json.decode(response.body);
    var question = Question.fromJson(answer);

    if (question.responseCode == 1)
      throw (Exception(codes[1]));
    else if (question.responseCode == 2)
      throw (Exception(codes[2]));
    else if (question.responseCode == 3)
      throw (Exception(codes[3]));
    else if (question.responseCode == 4) throw (Exception(codes[4]));

    return question.results;
  }
  else {
    throw Exception('Failure to launch');
  }
}

var codes = {
  0: 'Success Returned results successfully.',
  1: 'No Results Could not return results. The API doesn\'t have enough questions for your query. (Ex. Asking for 50 Questions in a Category that only has 20.)',
  2: 'Invalid Parameter Contains an invalid parameter. Arguements passed in aren\'t valid. (Ex. Amount = Five)',
  3: 'Token Not Found Session Token does not exist.',
  4: 'Token Empty Session Token has returned all possible questions for the specified query. Resetting the Token is necessary.'
};
