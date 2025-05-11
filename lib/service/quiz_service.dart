import 'dart:convert';

import 'package:http/http.dart' as http;

class QuizService {
  final String apiKey;

  QuizService(this.apiKey);

  Future<List<dynamic>> fetchQuestions({
    required String category,
    required String difficulty,
    required int questionLimit,
  }) async {
    final uri = Uri.parse(
      'https://quizapi.io/api/v1/questions'
      '?apiKey=$apiKey'
      '&category=$category'
      '&difficulty=$difficulty'
      '&limit=$questionLimit',
    );

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      throw Exception('Failed to fetch questions: $e');
    }
  }
}
