
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';



class StatusTrackerClass{
  bool _isFirstTime = true;
  int _currentStreak = 0;
  int _bestStreak = 0;
  int _daysPassed = 0;
  int _totalDays = 0;
  int _totalCurrectAnswers = 0;

// saving data according to given key
  saveValue(demandedKey,  value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (demandedKey == 'isFirstTime'){
    prefs.setBool(demandedKey, value);
    return;
  } else {
    prefs.setInt(demandedKey, value);
    return;
    }
  }

  //getting all saved data as a list
  getAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isFirstTime =  prefs.getBool('isFirstTime') ?? true;
    _currentStreak =  prefs.getInt('currentStreak') ?? 0;
    _bestStreak =  prefs.getInt('bestStreak') ?? 0;
    _daysPassed =  prefs.getInt('daysPassed') ?? 0;
    _totalDays = prefs.getInt('totalDays') ?? 0;
    _totalCurrectAnswers = prefs.getInt('totalCorrectAnswers') ?? 0;
    return [_isFirstTime, _currentStreak, _bestStreak, _daysPassed, _totalDays, _totalCurrectAnswers];
  }

}