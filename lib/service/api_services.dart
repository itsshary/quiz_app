import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quiz_app/utill/app_constants.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  Future<Response> fetchQuizByCategory(String category) async {
    try {
      final String endpoint = AppConstants.quizCategoryUri(category);
      final response = await _dio.get(endpoint);

      if (kDebugMode) {
        print('service${response.data}');
      }

      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<List<dynamic>> fetchQuizQuestions({
    required String category,
    required String difficulty,
    required int limit,
  }) async {
    final String apiKey = dotenv.env['API_KEY'] ?? '';
    final Uri uri = Uri.parse(
      'https://quizapi.io/api/v1/questions'
      '?apiKey=$apiKey'
      '&category=$category'
      '&difficulty=$difficulty'
      '&limit=$limit',
    );

    final response = await _dio.getUri(uri);
    return response.data;
  }
}
