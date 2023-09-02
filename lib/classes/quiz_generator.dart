import 'package:flutter/services.dart' show rootBundle;
import 'package:quizly/classes/quiz_class.dart';

class QuizGenerator {
  List _listOfQuizObjects = [];
  readTextFile() async {
    final myFile = rootBundle.loadString('assets/quizlist/quiz_list_file.txt');
    final contents = await myFile;
    List<String> everyQuizQuestionData = contents.split('##------------------------------------------------------------##');
    for (String questionData in everyQuizQuestionData) {
      final List<String> splitedQuestionData = questionData.split('--=-->');
      splitedQuestionData[1].split('-');
      QuizClass quizObject = QuizClass(
          splitedQuestionData[0],
          splitedQuestionData[1].split('-o:'),
          int.parse(splitedQuestionData[2]),
          splitedQuestionData[3].replaceAll('-Hint:', ''),
          splitedQuestionData[4].replaceAll('-LM:', ''));
      _listOfQuizObjects.add(quizObject);
    }
    return _listOfQuizObjects;
  }
}
