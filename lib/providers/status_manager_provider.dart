import 'package:flutter/cupertino.dart';
import 'dart:core';
import 'package:provider/provider.dart';

class StatusManagerProvider extends ChangeNotifier{
  bool _isFirstTime = false;
  int _currentStreak = 0;
  int _bestStreak = 0;
  int _daysPassed = 0;
  int _totalDays = 0;
  int _totalCurrectAnswers = 0;

  updateData(List<dynamic> listOfData){
    _isFirstTime = listOfData[0];
    _currentStreak = listOfData[1];
    _bestStreak = listOfData[2];
    _daysPassed = listOfData[3];
    _totalDays = listOfData[4];
    _totalCurrectAnswers = listOfData[5];
    notifyListeners();
  }

  getStoredData(String demandedData){
    if (demandedData == 'isFirstTime'){
      return _isFirstTime;
    } else if (demandedData == 'currentStreak'){
      return _currentStreak;
    } else if (demandedData == 'bestStreak'){
      return _bestStreak;
    } else if (demandedData == 'daysPassed'){
      return _daysPassed;
    } else if (demandedData == 'totalDays'){
      return _totalDays;
    } else if (demandedData == 'totalCorrectAnswers'){
      return _totalCurrectAnswers;
    } else {
      return 'demanded data is Undefined';
    }
  }


}