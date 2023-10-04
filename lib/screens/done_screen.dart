import 'package:flutter/material.dart';
import 'package:quizly/constants/constants.dart';

class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAtDonePageMainBackGroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(child: Image.asset(kAtDonePageDoneImagePngPath, scale: 1.5,)),
          const Column(
            children: [
              Text(kAtDonePageChallengeDoneTitleString, style: TextStyle(
              color: kAtDonePageChallengeDoneTitleTextColor,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
            ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 25.0),
                child: Text(kAtDonePageThankYouMessageString,
                  style: TextStyle(
                    color: kAtDonePageThankYouTextColor,
                    fontFamily: 'Poppins',
                    fontSize: 17.0,
                  ),
                ),
              ),],
          ),
        ],
      ),
    );
  }
}
