import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static const String appName = 'CodingQuiz';
  static const String taglineone = 'Boost Your';
  static const String secondtagline = 'Coding Knowledge';
  static const String letstart = "Let's Start";
  static const String enableTimer = "Enable Timer?";
  static const String questionRight = "All Questions are Correct!";
  static const String correctAnswer =
      "Check correct answer in full app version.";

  static const String baseUrl = 'https://quizapi.io';

  static String quizCategoryUri(String category) {
    final apiKey = dotenv.env['API_KEY'];
    return "/api/v1/questions?apiKey=$apiKey&category=$category";
  }

  static const List<String> categories = [
    'Nodejs',
    'HTML',
    'DevOps',
    'VueJS',
    'WordPress',
    'Postgres',
    'Linux',
    'Docker',
  ];

  static const List<String> difficulties = ['Easy', 'Medium', 'Hard'];
}
