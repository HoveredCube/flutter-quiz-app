import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizly/classes/status_tracker_class.dart';
import 'package:quizly/main.dart';
import '../providers/status_manager_provider.dart';
import 'home_page.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}



int currentPageIndex = 1;
// titles
String titleText1 = 'WELCOME!';
String titleText2 = 'Umm what?';
String titleText3 = 'Don’t Cheat';
String titleText4 = 'It’s Open';
String titleText5 = 'Let’s Start!';
// paragraphs
String paragraph1 = 'Welcome to the 90Quiz app, your new best friend for the next 90 days! ';
String paragraph2 = 'oh It’s more like a challenge! Get ready to challenge yourself with our daily quizzes and see how much you can learn in 90 days.';
String paragraph3 = 'Do not try to cheat! cause there is no reward for correct answers! the only reward here is the knowledge you gain!';
String paragraph4 = 'I mean Open source! That means if you’re a programmer, you can take a look at the source code and help us make it even better.';
String paragraph5 = 'Alright, let’s get started on this amazing journey! We hope you have a fantastic and rewarding experience with us.';


String getTitle(int currentIndex){
  if(currentIndex == 1){
    return titleText1;
  } else if (currentIndex == 2){
    return titleText2;
  } else if (currentIndex == 3){
    return titleText3;
  } else if (currentIndex == 4){
    return titleText4;
  } else {
    return titleText5;
  }
}

String getParagraph(int currentIndex){
  if(currentIndex == 1){
    return paragraph1;
  } else if (currentIndex == 2){
    return paragraph2;
  } else if (currentIndex == 3){
    return paragraph3;
  } else if (currentIndex == 4){
    return paragraph4;
  } else {
    return paragraph5;
  }
}

String nextButtonText ='Next';
String letsGoButtonText = "Let's GO";

String buttonText = nextButtonText;

class _WelcomePageState extends State<WelcomePage> {

  double opacityLevel = 1.0;


  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/images/welcomepage1.png'), context);
    precacheImage(const AssetImage('assets/images/welcomepage2.png'), context);
    precacheImage(const AssetImage('assets/images/welcomepage3.png'), context);
    precacheImage(const AssetImage('assets/images/welcomepage4.png'), context);
    precacheImage(const AssetImage('assets/images/welcomepage5.png'), context);
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails edetails) async {
        if (edetails.primaryVelocity! < 0) {
          // The drag gesture moved to the left
          if (currentPageIndex < 5){
            _changeOpacity();
            await Future.delayed(Duration(milliseconds: 170));
            setState(() {
              currentPageIndex += 1;
            });
            if(currentPageIndex == 5){
              setState(() {
                buttonText = letsGoButtonText;
              });
            }
            _changeOpacity();
          }
        } else {
          // The drag gesture moved to the right
          if (currentPageIndex > 1){
            _changeOpacity();
            await Future.delayed(const Duration(milliseconds: 170));
            setState(() {
              currentPageIndex -= 1;
            });
            if(currentPageIndex+1 == 5){
              setState(() {
                buttonText = nextButtonText;
              });
            }
            _changeOpacity();
          }
        }
        // print(details);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0C0C0C),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: AnimatedOpacity(
                opacity: opacityLevel,
                duration: Duration(milliseconds: 150),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/welcomepage$currentPageIndex.png', scale: 2.0,),
                    const SizedBox(height: 30.0,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getTitle(currentPageIndex), style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 43.0,
                            fontWeight: FontWeight.bold,
                          ),),
                          Text(getParagraph(currentPageIndex), style: const TextStyle(
                            color: Color(0xFFC1C1C1),
                            fontFamily: 'Poppins',
                            fontSize: 22.0,
                          ),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PageIndexCircle(isInPage: currentPageIndex == 1,),
                    PageIndexCircle(isInPage: currentPageIndex == 2,),
                    PageIndexCircle(isInPage: currentPageIndex == 3,),
                    PageIndexCircle(isInPage: currentPageIndex == 4,),
                    PageIndexCircle(isInPage: currentPageIndex == 5,),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 35.0, horizontal: 28.0),
                  child: SizedBox(
                    height: 80.0,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (currentPageIndex == 5){
                          StatusTrackerClass _statusTracker = StatusTrackerClass();
                          _statusTracker.saveValue('isFirstTime', false);
                          Provider.of<StatusManagerProvider>(context, listen: false)
                              .updateData(await _statusTracker.getAllData());
                          // _statusTracker.setFirstDate();
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context)=> HomePage()));
                        } else if (currentPageIndex < 5){
                          _changeOpacity();
                          await Future.delayed(const Duration(milliseconds: 170));
                          setState(() {
                            currentPageIndex += 1;
                          });
                          if(currentPageIndex == 5){
                            setState(() {
                              buttonText = letsGoButtonText;
                              statusObject.setFirstDate();
                            });
                          }
                          _changeOpacity();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEFF2FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(buttonText,
                        style: const TextStyle(
                          color: Color(0xFF030303),
                          fontFamily: 'Poppins',
                          fontSize: 45.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
//
class PageIndexCircle extends StatelessWidget {
  const PageIndexCircle({
    super.key, required this.isInPage,
  });
  final bool isInPage;
  double _getWidth(){
    if (isInPage){
      return 20.0;
    } else {
      return 10.0;
    }
  }
  Color _getColor(){
    if (isInPage){
      return const Color(0xFFFFFFFF);
    } else {
      return const Color(0xFF404040);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 230),
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      width: _getWidth(),
      height: 10.0,
      decoration: BoxDecoration(
          color: _getColor(),
        borderRadius: BorderRadius.circular(50)
      ),
    );
  }
}
