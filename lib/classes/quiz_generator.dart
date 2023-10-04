import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;
import 'package:quizly/classes/quiz_class.dart';
import 'dart:convert';

class QuizGenerator {
  final List _listOfQuizObjects = [];
  readJsonsFile() async{
    final String jsonString = await rootBundle.loadString('assets/quizlist/quizlist.json');
    final data = await json.decode(jsonString);
    for (int i = 1; i < 91; i++){
      var singleQuiz = data[i.toString()];
      QuizClass quizObject = QuizClass(singleQuiz["quiz"], [singleQuiz["option1"],singleQuiz["option2"],singleQuiz["option3"],singleQuiz["option4"]],int.parse(singleQuiz["correctAnswer"]), singleQuiz["hint"], singleQuiz["learnMore"]);
      _listOfQuizObjects.add(quizObject);
    }
    return _listOfQuizObjects;
  }
}
