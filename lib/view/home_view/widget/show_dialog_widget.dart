import 'package:flutter/material.dart';
import 'package:quiz_app/utill/app_constants.dart';
import 'package:quiz_app/view/quiz_view/quiz_view.dart';

Future<void> showStartQuizDialog(BuildContext context, String category) async {
  int questionLimit = 5;
  bool enableTimer = false;
  double timerMinutes = 1.0;
  String difficulty = 'Easy';

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Text('Start Quiz: $category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text('Questions:'),
                  const SizedBox(width: 10),
                  DropdownButton<int>(
                    value: questionLimit,
                    items: List.generate(16, (index) => index + 5)
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text('$e')))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => questionLimit = value!),
                  ),
                ],
              ),
              // Difficulty
              Row(
                children: [
                  const Text('Difficulty:'),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: difficulty,
                    items: AppConstants.difficulties
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => setState(() => difficulty = value!),
                  ),
                ],
              ),
              // Timer switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(AppConstants.enableTimer),
                  Switch(
                    value: enableTimer,
                    onChanged: (val) => setState(() => enableTimer = val),
                  ),
                ],
              ),
              // Timer duration (only visible if timer is on)
              if (enableTimer) ...[
                const SizedBox(height: 10),
                Text(
                    'Timer per question: ${timerMinutes.toStringAsFixed(1)} min'),
                Slider(
                  value: timerMinutes,
                  min: 0.5,
                  max: 5.0,
                  divisions: 9,
                  label: '${timerMinutes.toStringAsFixed(1)} min',
                  onChanged: (value) => setState(() => timerMinutes = value),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizScreen(
                      category: category,
                      difficulty: difficulty.toLowerCase(),
                      enableTimer: enableTimer,
                      questionLimit: questionLimit,
                      timerDuration:
                          enableTimer ? (timerMinutes * 60).toInt() : 10,
                    ),
                  ),
                );
              },
              child: const Text(
                'Start',
              ),
            ),
          ],
        );
      });
    },
  );
}
