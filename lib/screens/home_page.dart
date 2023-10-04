import 'package:flutter/material.dart';
import 'package:overlay_toast_message/overlay_toast_message.dart';
import 'package:provider/provider.dart';
import 'package:quizly/classes/quiz_generator.dart';
import 'package:quizly/classes/status_tracker_class.dart';
import 'package:quizly/constants/constants.dart';
import 'package:quizly/providers/quiz_oftheday_provider.dart';
import 'package:quizly/providers/status_manager_provider.dart';
import 'done_screen.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  StatusTrackerClass statusObject = StatusTrackerClass();

  assets(int currentStreak){
    if (currentStreak < 10){
      return 'assets/images/${currentStreak}streak.png';
    } else {
      return 'assets/images/10streak.png';
    }
  }
  Color getStreakColor(currentStreak){
    if (currentStreak < 6){
      return kAtHomePageStreakStringColor;
    } else {
      return kAtHomePageHotStreakStringColor;
    }
  }

  int tapEasterEggCount = 0;

  Widget isQuizAvailable(isOneDayPassed){
    if (isOneDayPassed){
      return Text(
        "Today's Quiz is ready!",
        style: TextStyle(
          color: Colors.white,
        ),
      );
    } else {
      return Text(
        "Come back tomorrow!",
        style: TextStyle(
          color: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAtHomePageMainBackGroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: (){
              tapEasterEggCount += 1;
              if (tapEasterEggCount > 10){
                OverlayToastMessage.show(
                  context,
                  textMessage: 'Developed By HoveredCube',
                  backgroundColor: Colors.greenAccent,
                  duration: const Duration(seconds: 3),
                  borderRadius: BorderRadius.circular(30),
                );
                tapEasterEggCount = 0;
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Consumer<StatusManagerProvider>(
                  builder: (context, statusProviderModel, child){
                    return Image.asset(
                      assets(statusProviderModel.getStoredData('currentStreak')),
                      scale: 1.30,
                    );
                  },
                 ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 45.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Consumer<StatusManagerProvider>(
                        builder: (context, statusProviderModel, child){
                          return Text(
                            //current streak
                            statusProviderModel.getStoredData('currentStreak').toString(),
                            style: const TextStyle(
                              fontFamily: 'Bungee',
                              color: kAtHomePageCurrentStreakNumberColor,
                              fontSize: 120.0,
                            ),
                          );
                        },
                      ),
                      Consumer<StatusManagerProvider>(
                        builder: (context, statusProviderModel, child) => Text.rich(
                            TextSpan(
                                children: [
                                  const TextSpan(
                                    text: kAtHomePageDaysString,
                                    style: TextStyle(color: kAtHomePageDaysStringColor, fontSize: 30.0, fontFamily: 'Bungee'),
                                  ),
                                  TextSpan(
                                    text: kAtHomePageStreakString,
                                    style: TextStyle(color: getStreakColor(statusProviderModel.getStoredData('currentStreak')), fontSize: 30.0, fontFamily: 'Bungee'),
                                  ),
                                ]
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Consumer<StatusManagerProvider>(
                builder: (context, statusProviderModel, child){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StatusCardCostumeWidget(numText: statusProviderModel.getStoredData('bestStreak').toString(), titleText: kAtHomePageBestStreakTitleString,),
                      StatusCardCostumeWidget(numText: '${statusProviderModel.getStoredData('daysPassed').toString()}/90', titleText: kAtHomePageDaysPassedTitleString,),
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 5.0, right:5.0,),
                child: Container(
                  width: 330.0,
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: kAtHomePageCardOnBackgroundColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(kAtHomePageTotalCorrectAnswersTitleString, style: TextStyle(
                          color: kAtHomePageTotalCorrectAnswersTitleColor,
                          fontFamily: 'Poppins',
                          fontSize: 17.0,
                        ),),
                        Consumer<StatusManagerProvider>(
                          builder: (context, statusProviderModel, child){
                            return Text(
                              statusProviderModel.getStoredData('totalCorrectAnswers').toString(), style: const TextStyle(color: kAtHomePageTotalCorrectAnswersNumberColor,
                              fontFamily: 'Poppins',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 80.0,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Consumer<StatusManagerProvider>(
                    builder: (context, statusProviderModel, child){
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kAtHomePageStartButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async{
                          QuizGenerator quizGeneratorObject = await QuizGenerator();
                          var quizObjectList = await quizGeneratorObject.readJsonsFile();
                          if (await statusObject.getIfOneDayPassed()){
                            if (statusProviderModel.getStoredData('daysPassed') <= 90){
                              await Provider.of<QuizOfTheDayProvider>(context, listen: false).splitQuizData(quizObjectList[statusProviderModel.getStoredData('daysPassed')]);
                              Navigator.pushNamed(context, '/QuizPage');
                            } else {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DonePage()));
                            }
                          } else {
                            OverlayToastMessage.show(
                              context,
                              textMessage: 'Not yet, try tomorrow!',
                              backgroundColor: kAtQuizPageErrorMessageBackGroundColor,
                              duration: const Duration(seconds: 3),
                              borderRadius: BorderRadius.circular(30),
                            );
                          }
                        },
                        child: const Text(kAtHomePageStartButtonText,
                          style: TextStyle(
                            color: kAtHomePageStartButtonTextColor,
                            fontFamily: 'Poppins',
                            fontSize: 45.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10.0,),
            ],
          ),
        ],
      )
    );
  }
}


// status card costume widget
class StatusCardCostumeWidget extends StatelessWidget {
   const StatusCardCostumeWidget({
    super.key, this.numText, this.titleText,
  });

  final numText;
  final titleText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        constraints: const BoxConstraints(minWidth: 160, maxWidth: 170),
        height: 100.0,
        decoration: BoxDecoration(
          color: kAtHomePageCardOnBackgroundColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(numText, style: const TextStyle(color: kAtHomePageCostumeStatusCardNumberColor,
            fontFamily: 'Poppins',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              ),
            ),
            Text(titleText, style: const TextStyle(
              color: kAtHomePageCostumeStatusCardTitleColor,
              fontFamily: 'Poppins',
              fontSize: 18.0,
            ),),
          ],
        ),
      ),
    );
  }
}

