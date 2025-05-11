import 'dart:async';

class QuizTimer {
  Timer? _timer;
  int _timeLeft;
  final Function onTimerComplete;
  final Function(int timeLeft) onTick;

  QuizTimer({
    required int duration,
    required this.onTimerComplete,
    required this.onTick,
  }) : _timeLeft = duration;

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft == 0) {
        onTimerComplete();
      } else {
        _timeLeft--;
        onTick(_timeLeft);
      }
    });
  }

  void stop() => _timer?.cancel();
}
