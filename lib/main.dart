import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizly/classes/status_tracker_class.dart';
import 'package:quizly/providers/quiz_oftheday_provider.dart';
import 'package:quizly/providers/radio_button_provider.dart';
import 'package:quizly/providers/results_page_provider.dart';
import 'package:quizly/providers/status_manager_provider.dart';
import 'package:quizly/screens/done_screen.dart';
import 'package:quizly/screens/home_page.dart';
import 'package:quizly/screens/quiz_page.dart';
import 'package:quizly/screens/results_page.dart';
import 'package:quizly/screens/splash_screen.dart';
import 'package:quizly/screens/welcome_page1.dart';

void main() {
  runApp(const MyApp());
}

StatusTrackerClass statusObject = StatusTrackerClass();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<RadioButtonProvider>(
              create: (_) => RadioButtonProvider()),
          ChangeNotifierProvider<StatusManagerProvider>(
              create: (_) => StatusManagerProvider()),
          ChangeNotifierProvider<QuizOfTheDayProvider>(
              create: (_) => QuizOfTheDayProvider()),
          ChangeNotifierProvider(
              create: (_) => ResultsPageProvider()),
        ],
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/homepage': (context) => HomePage(),
            '/QuizPage': (context) => const QuizPage(),
            '/ResultsPage': (context) => const ResultsPage(),
            '/Welcome': (context) => const WelcomePage(),
            '/DonePage': (context) => const DonePage(),
          },
        ));
  }
}
