import 'dart:async';

class GameService {
  int currentQuarter = 1;
  final int totalQuarters = 4;
  Duration quarterDuration = Duration(minutes: 12);
  Timer? gameTimer;
  int timeLeftInSeconds = 12 * 60; // 12 minutos por cuarto
  bool gameEnded = false;

  // Iniciar cronómetro
  void startTimer(Function onTimeUpdate, Function onQuarterEnd, Function onGameEnd) {
    gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeftInSeconds > 0) {
        onTimeUpdate(timeLeftInSeconds);
        timeLeftInSeconds--;
      } else {
        timer.cancel();
        if (currentQuarter < totalQuarters) {
          currentQuarter++;
          onQuarterEnd(currentQuarter);
        } else {
          gameEnded = true;
          onGameEnd();
        }
      }
    });
  }

  // Restablecer el cronómetro para el siguiente cuarto
  void resetForNextQuarter(Function onQuarterReady) {
    timeLeftInSeconds = 12 * 60; // Restablecer tiempo
    onQuarterReady(timeLeftInSeconds);
  }

  void stopTimer() {
    gameTimer?.cancel();
  }

  // Resetear todos los valores
  void resetGame(Function onReset) {
    currentQuarter = 1;
    timeLeftInSeconds = 12 * 60;
    gameEnded = false;
    stopTimer();
    onReset(timeLeftInSeconds, currentQuarter);
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }
}