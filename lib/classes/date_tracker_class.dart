import 'package:quizly/main.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DateTracker{
  setFirstDate()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("installDate",DateTime.now().toString());
  }

  getDaysCount(bool SaveValue)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime installDate = DateTime.parse(prefs.getString("installDate").toString());
    int daysInBetween = daysBetween(installDate, DateTime.now());
    if(SaveValue){
      statusObject.saveValue('daysPassed', daysInBetween);
    }
    return daysInBetween;
  }
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}