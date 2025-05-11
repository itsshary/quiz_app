import 'package:flutter/material.dart';
import 'package:quiz_app/routes/routes_name.dart';
import 'package:quiz_app/view/home_view/home_view.dart';
import 'package:quiz_app/view/quiz_view/quiz_view.dart';
import 'package:quiz_app/view/splash_view/splash_view.dart';
import 'package:quiz_app/view/starting_view/starting_view.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routesname.splashView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());
      case Routesname.startingView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const StartingView());
      case Routesname.homeView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case Routesname.quizView:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => QuizScreen(
            category: args['category'],
            difficulty: args['difficulty'],
            enableTimer: args['enableTimer'],
            questionLimit: args['questionLimit'],
            timerDuration: args['timerDuration'],
          ),
        );

      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Scaffold(
                  body: Center(
                    child: Text("No Routes Defines"),
                  ),
                ));
    }
  }
}
