import 'package:flutter/cupertino.dart';

import '../constants/constants.dart';


class ResultsPageProvider extends ChangeNotifier{

  String _learnMore = 'loading learn more message ... ';
  int _dayPassed = 0;
  int _streak= 0;
  bool _AnswerWasCorrect = false;
  String _welldoneImageAssetPath = kAtResultsPageWelldoneImageAssetPath;
  String _wrongImageAssetPath = kAtResultsPageWrongImageAssetPath;
  String _StarIconPath = kAtResultsPageStarIconPath;
  String _WrongIconPath = kAtResultsPageWrongIconPath;


  setNeededData(bool wasAnswerCorrect ,String learnMore, int daysPassed, int currentStreak){
    _AnswerWasCorrect = wasAnswerCorrect;
    _learnMore = learnMore;
    _dayPassed = daysPassed;
    _streak = currentStreak;
    notifyListeners();
  }



  getPrimaryColor(){
    if(_AnswerWasCorrect){
      return kAtResultsPageAnswerWasCorrectPrimaryColor;
    } else {
      return kAtResultsPageAnswerWasWrongPrimaryColor;
    }
  }
  getImage(){
    if(_AnswerWasCorrect){
      return _welldoneImageAssetPath;
    } else {
      return _wrongImageAssetPath;
    }
  }
  getIcon(){
    if (_AnswerWasCorrect){
      return _StarIconPath;
    } else {
      return _WrongIconPath;
    }
  }
  getMessage(){
    if(_AnswerWasCorrect){
      return kAtResultsPageStatusMessageCorrectAnswerTextString;
    } else {
      return kAtResultsPageStatusMessageWrongAnswerTextString;
    }
  }
  getTodaysCount(){
    return _dayPassed + 1;
  }
  getStreak(){
    if (_AnswerWasCorrect){
      return _streak + 1;
    } else {
      return 0;
    }
  }
  getLearnMore(){
    return _learnMore;
  }
}