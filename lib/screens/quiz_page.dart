import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:quizly/providers/radio_button_provider.dart';
import 'package:quizly/providers/results_page_provider.dart';
import 'package:quizly/screens/results_page.dart';
import '../constants/constants.dart';
import '../main.dart';
import '../providers/quiz_oftheday_provider.dart';
import '../providers/status_manager_provider.dart';
import 'package:overlay_toast_message/overlay_toast_message.dart';


class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
        child: Scaffold(
        backgroundColor: kAtQuizPageMainBackGroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset( kAtQuizPageQuestionMarkPngPath, scale: 1.37,),
            const SizedBox(height: 10.0,),
            Container(
              height: 474.0,
              margin: const EdgeInsets.symmetric(horizontal: 13.0),
              decoration: BoxDecoration(
                color: kAtQuizPageQuizCardColor,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20.0, left: 20.0, top: 30.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 5.0),
                              // constraints: BoxConstraints.expand(),
                              width: 5.0,
                              height: 5.0,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF4A67FF),
                                  borderRadius: BorderRadius.circular(20.0)
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Container(
                              // constraints: BoxConstraints.expand(),
                              width: 5.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                // color: Color(0xFF4A67FF),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF4A67FF),
                                      Color(0xFF131313),
                                    ],
                                    stops: [0.01, 7.0],
                                    begin: AlignmentDirectional.topCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0)
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8.0,),
                        Flexible(
                          child: Consumer<QuizOfTheDayProvider>(
                            builder: (context, providerModel, child){
                              return Text.rich(
                                  TextSpan(
                                      text: providerModel.getQuizData()[0],
                                      style: const TextStyle(
                                        color: kAtQuizPageQuizQuestionTextColor,
                                        fontFamily: 'Poppins',
                                        fontSize: 17.0,
                                      )
                                  )
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  Consumer<QuizOfTheDayProvider>(
                    builder: (context, providerModel, child){
                      return Column(
                        children: [
                          OptionCostumeWidget(
                            optionValue: 0, optionTitle: providerModel.getQuizData()[1],),
                          OptionCostumeWidget(
                            optionValue: 1, optionTitle: providerModel.getQuizData()[2],),
                          OptionCostumeWidget(
                            optionValue: 2, optionTitle: providerModel.getQuizData()[3],),
                          OptionCostumeWidget(
                            optionValue: 3, optionTitle: providerModel.getQuizData()[4],)
                        ],
                      );
                    }
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(32.0)),
                              child: Container(
                                height: 340.0,
                                width: 100.0,
                                decoration: BoxDecoration(
                                  color: kAtQuizPageHintDialogCardColor,
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(
                                      color: kAtQuizPageHintDialogBorderColor,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Stack(
                                        alignment: AlignmentDirectional.bottomCenter,
                                        children: [
                                          Container(
                                            width: 80.0,
                                            height: 38.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7.0),
                                              border: Border.all(
                                                  color: kAtQuizPageHintDecorationBorderColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 80.0,
                                            height: 5.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7.0),
                                              color: kAtQuizPageHintDecorationUnderLineColor,
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: kAtQuizPageHintDecorationUnderLineGlowColor,
                                                  spreadRadius: 4,
                                                  blurRadius: 13,
                                                  offset: Offset(0,3),
                                                ),
                                              ],
                                            ),

                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(bottom: 6.0),
                                            child: Text(kAtQuizPageHintDialogTitleText,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: kAtQuizPageHintDialogTitleTextColor
                                            ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 203.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 30.0),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Consumer<QuizOfTheDayProvider>(
                                            builder: (context, providerModel, child){
                                              return Text(
                                                providerModel.getQuizData()[5],
                                                style: const TextStyle(
                                                  color: kAtQuizPageHintDialogHintTextColor,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 15.0,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 14.0,
                                    ),
                                    SizedBox(
                                      width: 220.0,
                                      height: 45.0,
                                      child: ElevatedButton(
                                          onPressed: () => Navigator.of(context).pop(true),
                                        style: ElevatedButton.styleFrom(
                                          side: const BorderSide(
                                            color: kAtQuizPageHintDialogButtonBorderColor,
                                          ),
                                          backgroundColor: kAtQuizPageHintDialogButtonBackgroundColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                          child: const Text(kAtQuizPageHintDialogButtonText, style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 20.0,
                                          ),
                                          ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        );
                        },

                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        color: kAtQuizPageHintButtonBorderColor,
                      ),
                      backgroundColor: kAtQuizPageHintButtonBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                      child: SvgPicture.asset(kAtQuizPageLightBulbIconPath),
                  ),
                ],
              ),
            )
          ],
        ),
            Consumer<QuizOfTheDayProvider>(
                builder: (context, quizOfTheDayProvider, child){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Consumer<RadioButtonProvider>(
                          builder: (context, radioButtonProvider, child){
                            return Consumer<StatusManagerProvider>(
                              builder: (context, statusManagerProvider, child) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kAtQuizPageChooseButtonColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: ()  async {
                                    if (radioButtonProvider.selectedValue() == 4){
                                      OverlayToastMessage.show(
                                        context,
                                        textMessage: kAtQuizPageErrorMessageText,
                                        backgroundColor: kAtQuizPageErrorMessageBackGroundColor,
                                        duration: const Duration(seconds: 3),
                                        borderRadius: BorderRadius.circular(30),
                                      );
                                    } else if (radioButtonProvider.selectedValue()+1 == quizOfTheDayProvider.getQuizData()[6]){
                                      //if the answer was correct:
                                      // updating the current streak
                                      statusObject.saveValue('currentStreak', statusManagerProvider.getStoredData('currentStreak') + 1);
                                      // check if it's a best streak
                                      if (statusManagerProvider.getStoredData('currentStreak') + 1 > statusManagerProvider.getStoredData('bestStreak')){
                                        // update best streak to the new value
                                        statusObject.saveValue('bestStreak', statusManagerProvider.getStoredData('currentStreak') + 1);
                                      }
                                      // add to total correct answers
                                      statusObject.saveValue('totalCorrectAnswers', statusManagerProvider.getStoredData('totalCorrectAnswers') + 1);
                                      Provider.of<ResultsPageProvider>(context, listen: false)
                                          .setNeededData(true, quizOfTheDayProvider.getQuizData()[7], statusManagerProvider.getStoredData('daysPassed'), statusManagerProvider.getStoredData('currentStreak'));
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){ return ResultsPage();}));
                                      statusObject.setLatestQuizTookLogin();
                                    } else {
                                      statusObject.saveValue('currentStreak', 0);
                                      Provider.of<ResultsPageProvider>(context, listen: false)
                                          .setNeededData(false, quizOfTheDayProvider.getQuizData()[7], statusManagerProvider.getStoredData('daysPassed'), statusManagerProvider.getStoredData('currentStreak'));
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){ return ResultsPage();}));
                                      statusObject.setLatestQuizTookLogin();
                                    }
                                    // updating the state of the app after all that calculations and stuff
                                    statusManagerProvider.updateData(await statusObject.getAllData());
                                  },
                                  child: const Text( kAtQuizPageChooseButtonText,
                                    style: TextStyle(
                                      color: kAtQuizPageButtonTextColor,
                                      fontFamily: 'Poppins',
                                      fontSize: 45.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                      ),
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}

class OptionCostumeWidget extends StatelessWidget {
  const OptionCostumeWidget({
    super.key, required this.optionValue, required this.optionTitle,
  });

  final optionValue;
  final optionTitle;

  @override
  Widget build(BuildContext context) {
    return Consumer<RadioButtonProvider>(
      builder: (context, theProvider, child) {
        return GestureDetector(
          onTap: () {
            theProvider.changeSelectedValueTo(optionValue);
            if (optionValue == theProvider.selectedValue()) {
              theProvider.changeContainerStyle(optionValue);
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            width: double.infinity,
            height: 60.0,
            decoration: BoxDecoration(
              color: theProvider.getContainerStyle()[optionValue][0],
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: theProvider.getContainerStyle()[optionValue][1],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  activeColor: kAtQuizPageRadioButtonActiveColor,
                  value: optionValue,
                  groupValue: theProvider.selectedValue(),
                  onChanged: (value) {
                    theProvider.changeSelectedValueTo(value);
                    theProvider.changeSelectedValueTo(optionValue);
                    if (optionValue == theProvider.selectedValue()) {
                      theProvider.changeContainerStyle(optionValue);
                    }
                  },
                ),
                Text(optionTitle, style: TextStyle(
                  color: theProvider.getContainerStyle()[optionValue][2],
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

