import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app/repository/quiz_repository.dart';

class QuizViewModel extends ChangeNotifier {
  final QuizRepository _repository = QuizRepository();

  List<dynamic> questions = [];
  int currentIndex = 0;
  bool isLoading = true;
  bool isError = false;
  int correctCount = 0;
  int wrongCount = 0;
  List<Map<String, dynamic>> wrongQuestions = [];

  String? selectedAnswerKey;
  bool isAnswered = false;
  Timer? _timer;
  int timeLeft = 30;

  Future<void> loadQuestions(
      String category, String difficulty, int limit) async {
    try {
      isLoading = true;
      notifyListeners();

      questions = await _repository.getQuizQuestions(
        category: category,
        difficulty: difficulty,
        limit: limit,
      );

      isLoading = false;
    } catch (e) {
      isError = true;
    }

    notifyListeners();
  }

  void handleAnswer(String? selectedKey) {
    selectedAnswerKey = selectedKey;
    isAnswered = true;

    final correctAnswers =
        questions[currentIndex]['correct_answers'] as Map<String, dynamic>;
    final correctEntry = correctAnswers.entries.firstWhere(
      (entry) => entry.value == 'true',
    );
    final correctKey = correctEntry.key.replaceAll('_correct', '');
    if (selectedKey != null && selectedKey == correctKey) {
      correctCount++;
    } else {
      wrongCount++;
      wrongQuestions.add(questions[currentIndex]);
    }

    stopTimer();
    notifyListeners();
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      currentIndex++;
      selectedAnswerKey = null;
      isAnswered = false;
      notifyListeners();
    }
  }

  void startTimer(int duration, void Function() onTimeUp) {
    timeLeft = duration;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeLeft--;
      if (timeLeft <= 0) {
        stopTimer();
        onTimeUp();
      }
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }
}
