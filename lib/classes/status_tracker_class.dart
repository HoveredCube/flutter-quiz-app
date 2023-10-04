
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

  setFirstDate()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("installDate",DateTime.now().toString());
  }
  getDaysCount(bool SaveValue)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime installDate = DateTime.parse(prefs.getString("installDate").toString());
    int daysInBetween = daysBetween(installDate, DateTime.now());
    if(SaveValue){
      saveValue('daysPassed', daysInBetween);
    }
    return daysInBetween;
  }
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
  setLatestQuizTookLogin()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString( 'latestQuizTookDate', DateTime.now().toString() );
  }
  Future<bool> getIfOneDayPassed()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var latestQuizTook = prefs.getString('latestQuizTookDate');
    if (latestQuizTook == null){
      return true;
    } else {
      var timePassed = await daysBetween( DateTime.parse(prefs.getString('latestQuizTookDate') ?? DateTime.now().toString() .toString()), DateTime.now());
      if (timePassed >= 1){
        return true;
      } else {
        return false;
      }
    }
  }
}