import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:quizly/classes/status_tracker_class.dart';
import 'package:flutter/services.dart';
import 'package:quizly/providers/status_manager_provider.dart';
import 'package:quizly/screens/done_screen.dart';
import 'package:quizly/screens/home_page.dart';
import 'package:quizly/screens/welcome_page1.dart';
import '../constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  @override
  void initState(){
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async{
    // loadImage();
    await Future.delayed(const Duration(milliseconds: 2000));
    StatusTrackerClass statusTracker = StatusTrackerClass();
    List recievedValues = await statusTracker.getAllData();
    if (recievedValues[0]){
      await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context)=> WelcomePage()),
      );
    } else {
      statusTracker.getDaysCount(true);
      recievedValues = await statusTracker.getAllData();
      if (recievedValues[3] >=91 ){
        await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context)=> DonePage()),
        );
      } else {
        statusTracker.getDaysCount(true);
        recievedValues = await statusTracker.getAllData();
        Provider.of<StatusManagerProvider>(context, listen: false)
            .updateData(recievedValues);
        await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context)=> HomePage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
     precacheImage(const AssetImage('assets/images/questionMark.png'), context);
     precacheImage(const AssetImage('assets/images/welldone design.png'), context);
     precacheImage(const AssetImage('assets/images/wrong design.png'), context);
     precacheImage(const AssetImage('assets/images/final done image.png'), context);
    return Scaffold(
      backgroundColor: const Color(0xFF0C0C0C),
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: SizedBox(
                    width: 180.0,
                    child: Image.asset(kAtSplashScreenLogoPath, scale: 2.0,).animate().fade(duration: const Duration(seconds: 1),).slideY(begin: 0.01, end: 0, curve: Curves.easeIn ),
                ),
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: const Text('By HoveredCube', style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xFFAEAEAE),
                fontWeight: FontWeight.normal,
                fontSize: 20.0,
              ),).animate().fade(duration: const Duration(milliseconds: 1700), curve: Curves.easeIn)
            ),
            const SizedBox(height: 75.0,),
          ],
        ),
      ),
    );
  }
}
