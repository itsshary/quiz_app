import 'package:quiz_app/models/quiz_category_model.dart';
import 'package:quiz_app/service/api_services.dart';

class QuizRepository {
  final ApiService _apiService = ApiService();

  // for quiz catagory
  Future<List<QuizCategoryModel>> getQuizQuestions({
    required String category,
    required String difficulty,
    required int limit,
  }) async {
    final data = await _apiService.fetchQuizQuestions(
      category: category,
      difficulty: difficulty,
      limit: limit,
    );

    return data.map((e) => QuizCategoryModel.fromJson(e)).toList();
  }
}
