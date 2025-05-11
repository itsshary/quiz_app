import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:quiz_app/utill/app_constants.dart';
import 'package:quiz_app/view/quiz_view_result/widget/confitte_widget.dart';

class QuizResultScreen extends StatefulWidget {
  final int total;
  final int correct;
  final int wrong;
  final List<Map<String, dynamic>> wrongQuestions;

  const QuizResultScreen({
    super.key,
    required this.total,
    required this.correct,
    required this.wrong,
    required this.wrongQuestions,
  });

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));

    if (widget.correct == widget.total) {
      Future.delayed(Duration.zero, () {
        _confettiController.play();
        showCongratulationsDialog(
          // ignore: use_build_context_synchronously
          context, _confettiController,
        );
      });
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Result')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Questions: ${widget.total}',
                style: const TextStyle(fontSize: 18)),
            Text('Correct: ${widget.correct}',
                style: const TextStyle(fontSize: 18, color: Colors.green)),
            Text('Wrong: ${widget.wrong}',
                style: const TextStyle(fontSize: 18, color: Colors.red)),
            const SizedBox(height: 20),
            const Text('Wrong Questions:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.wrongQuestions.length,
                itemBuilder: (_, i) {
                  final q = widget.wrongQuestions[i];
                  return ListTile(
                    title: Text(q['question'] ?? 'No question'),
                    subtitle: const Text(AppConstants.correctAnswer),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
