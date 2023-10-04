import 'package:flutter/cupertino.dart';
import '../classes/quiz_class.dart';

class QuizOfTheDayProvider extends ChangeNotifier{

  var _quizQuestion = 'loading todays quiz...';
  var _option1 = 'loading option...';
  var _option2 = 'loading option...';
  var _option3 = 'loading option...';
  var _option4 = 'loading option...';
  var _hint = 'loading the hint String...';
  var _currentAnswer = 0;
  var _learnMore = 'loading learn more...';

  splitQuizData(QuizClass quizObject)  {
    _quizQuestion = quizObject.quizQuestion.trim();
    _option1 = quizObject.options[0].trim();
    _option2 = quizObject.options[1].trim();
    _option3 = quizObject.options[2].trim();
    _option4 = quizObject.options[3].trim();
    _hint = quizObject.hint;
    _currentAnswer = quizObject.theCorrectOptionNumber;
    _learnMore = quizObject.learnMore;
    notifyListeners();
  }
  getQuizData(){
    return [_quizQuestion, _option1, _option2, _option3, _option4, _hint, _currentAnswer, _learnMore];
  }
}