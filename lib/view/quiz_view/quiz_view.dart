import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quiz_app/service/quiz_service.dart';
import 'package:quiz_app/utill/styles.dart';
import 'package:quiz_app/view/quiz_view/classes/timer_class.dart';
import 'package:quiz_app/view/quiz_view_result/quiz_result.dart';

class QuizScreen extends StatefulWidget {
  final String category;
  final String difficulty;
  final bool enableTimer;
  final int questionLimit;
  final int timerDuration;

  const QuizScreen({
    super.key,
    required this.category,
    required this.difficulty,
    required this.enableTimer,
    required this.questionLimit,
    required this.timerDuration,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<dynamic> _questions = [];
  int _currentIndex = 0;
  bool _isLoading = true;
  final CountDownController _countDownController = CountDownController();

  bool _isError = false;

  String? _selectedAnswerKey;
  bool _isAnswered = false;

  int _correctCount = 0;
  int _wrongCount = 0;
  List<Map<String, dynamic>> _wrongQuestions = [];

  late QuizTimer _quizTimer;

  @override
  void initState() {
    super.initState();
    final apiKey = dotenv.env['API_KEY'] ?? '';
    fetchQuestions(apiKey);
  }

  void fetchQuestions(String apiKey) async {
    try {
      final questions = await QuizService(apiKey).fetchQuestions(
        category: widget.category,
        difficulty: widget.difficulty,
        questionLimit: widget.questionLimit,
      );
      setState(() {
        _questions = questions;
        _isLoading = false;
      });

      if (widget.enableTimer) {
        _quizTimer = QuizTimer(
          duration: widget.timerDuration,
          onTimerComplete: () => handleAnswer(null),
          onTick: (timeLeft) {},
        );
        _quizTimer.start();
      } else {}
    } catch (e) {
      setState(() => _isError = true);
    }
  }

  void handleAnswer(String? selectedKey) {
    _quizTimer.stop();
    setState(() {
      _selectedAnswerKey = selectedKey;
      _isAnswered = true;
      final correctAnswers =
          _questions[_currentIndex]['correct_answers'] as Map<String, dynamic>;
      final correctKey = correctAnswers.entries
          .firstWhere((entry) => entry.value == 'true',
              orElse: () => const MapEntry('', ''))
          .key
          .replaceAll('_correct', '');

      if (selectedKey != null && selectedKey == correctKey) {
        _correctCount++;
      } else {
        _wrongCount++;
        _wrongQuestions.add(_questions[_currentIndex]);
      }
    });
  }

  void nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswerKey = null;
        _isAnswered = false;
      });
      if (widget.enableTimer) {
        _quizTimer.start();
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => QuizResultScreen(
            total: widget.questionLimit,
            correct: _correctCount,
            wrong: _wrongCount,
            wrongQuestions: _wrongQuestions,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _quizTimer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_isError || _questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: const Center(child: Text('Failed to load questions')),
      );
    }

    final question = _questions[_currentIndex];
    final answers = question['answers'] as Map<String, dynamic>? ?? {};
    final correctAnswers =
        question['correct_answers'] as Map<String, dynamic>? ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_currentIndex + 1}/${_questions.length}'),
        actions: [
          if (widget.enableTimer)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularCountDownTimer(
                duration: widget.timerDuration,
                initialDuration: 0,
                controller: _countDownController,
                width: 40,
                height: 40,
                ringColor: Colors.grey[300]!,
                fillColor: Colors.red,
                backgroundColor: Colors.white,
                strokeWidth: 4.0,
                strokeCap: StrokeCap.round,
                textStyle: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                isReverse: true,
                isReverseAnimation: true,
                autoStart: true,
                onComplete: () {
                  handleAnswer(null); // No answer selected
                },
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                question['question'] ?? 'No question',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            ...answers.entries.map((entry) {
              final key = entry.key;
              final value = entry.value;
              if (value == null) return const SizedBox();

              final isCorrect = correctAnswers['${key}_correct'] == 'true';
              final isSelected = key == _selectedAnswerKey;

              Color? tileColor;
              if (_isAnswered) {
                if (isSelected && isCorrect) {
                  tileColor = Colors.green.shade200;
                } else if (isSelected && !isCorrect) {
                  tileColor = Colors.red.shade200;
                } else if (isCorrect) {
                  tileColor = Colors.green.shade100;
                }
              }

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text(value, style: commonTextStyle(context)),
                  tileColor: tileColor,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Colors.amber,
                          strokeAlign: 10.0,
                          style: BorderStyle.solid,
                          width: 1.0),
                      borderRadius: BorderRadius.circular(10)),
                  onTap: _isAnswered ? null : () => handleAnswer(key),
                ),
              );
            }),
            const Spacer(),
            ElevatedButton(
              onPressed: _isAnswered ? nextQuestion : null,
              child: Text(
                _currentIndex == _questions.length - 1 ? 'Finish' : 'Next',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
