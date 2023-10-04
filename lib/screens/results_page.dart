import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quizly/classes/status_tracker_class.dart';
import 'package:quizly/providers/results_page_provider.dart';
import '../constants/constants.dart';
import 'done_screen.dart';
import 'home_page.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: kAtResultsPageMainBackGroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<ResultsPageProvider>(
                builder: (context, resultsPageProvider, child){
                  return SizedBox(
                    width: double.infinity,
                    child: Image.asset(resultsPageProvider.getImage(), fit: BoxFit.contain,),
                  );
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Consumer<ResultsPageProvider>(
                      builder: (context, resultsPageProvider, child){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 7.0),
                              width: 240.0,
                              height: 32.0,
                              decoration: BoxDecoration(
                                color: resultsPageProvider.getPrimaryColor(),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(resultsPageProvider.getIcon()),
                                  Text(
                                    resultsPageProvider.getMessage(),
                                    style: const TextStyle(
                                      color: kAtResultsPageStatusMessageTextColor,
                                      fontFamily: 'Poppins',
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 6.0),
                              child: Text.rich(
                                TextSpan(
                                    children: [
                                      TextSpan(text: 'Day ${resultsPageProvider.getTodaysCount()}/90 - ',
                                        style: const TextStyle(
                                          color: kAtResultsPageDayCounterTextColor,
                                          fontFamily: 'Poppins',
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      TextSpan(text: 'Streak : ${resultsPageProvider.getStreak()}',
                                        style: TextStyle(
                                          color: resultsPageProvider.getPrimaryColor(),
                                          fontFamily: 'Poppins',
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ]
                                ),

                              ),
                            )
                          ],
                        );
                      }
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14.0),
                padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 23.0, bottom: 34.0),
                width: double.infinity,
                height: 290.0,
                decoration: BoxDecoration(
                  color: kAtResultsPageContainerCardColor,
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: RawScrollbar(
                  radius: const Radius.circular(20.0),
                  thickness: 1.5,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text( kAtResultsPageLearnMoreTextString, style: TextStyle(
                          color: kAtResultsPageLearnMoreTitleColor,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          ),
                        ),
                        Consumer<ResultsPageProvider>(
                          builder: (context, resultsPageProvider, child){
                            return Text(
                              resultsPageProvider.getLearnMore(),
                              style: const TextStyle(
                                color: kAtResultsPageLearnMoreTextColor,
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                              ),
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAtResultsPageCoolButtonBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  StatusTrackerClass statusTrackerObject = await StatusTrackerClass();
                  List allData = await statusTrackerObject.getAllData();
                  if (allData[3] >=91 ){
                    await Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context)=> const DonePage()),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context)=> HomePage()),
                    );
                  }
                },
                child: const Text(kAtResultsPageCoolButtonTextString,
                  style: TextStyle(
                    color: kAtResultsPageCoolButtonTextColor,
                    fontFamily: 'Poppins',
                    fontSize: 45.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
