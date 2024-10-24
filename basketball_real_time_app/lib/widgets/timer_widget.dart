import 'package:flutter/material.dart';
import '../services/game_service.dart';

class TimerWidget extends StatefulWidget {
  final GameService gameService;

  TimerWidget({required this.gameService});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  String time = "12:00";
  bool isRunning = false;
  int currentQuarter = 1;
  bool gameEnded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          gameEnded ? 'Juego Finalizado' : 'Cuarto: $currentQuarter',
          style: const TextStyle(fontSize: 24),
        ),
        // Temporizador
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Text(
              time.toString().padLeft(2, '0'),
              style: const TextStyle(
                fontSize: 100,
                fontFamily: 'Digital', // Asegúrate de usar una fuente de estilo digital
                color: Colors.red,
              ),
            ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: isRunning || gameEnded
                  ? null
                  : () {
                      setState(() {
                        isRunning = true;
                      });
                      widget.gameService.startTimer(
                        (secondsLeft) {
                          setState(() {
                            time = widget.gameService.formatTime(secondsLeft);
                          });
                        },
                        (newQuarter) {
                          setState(() {
                            isRunning = false;
                            currentQuarter = newQuarter;
                          });
                          widget.gameService.resetForNextQuarter((newTimeLeft) {
                            setState(() {
                              time = widget.gameService.formatTime(newTimeLeft);
                            });
                          });
                        },
                        () {
                          setState(() {
                            gameEnded = true;
                            isRunning = false;
                          });
                        },
                      );
                    },
              child: Text('Iniciar'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: isRunning ? () {
                setState(() {
                  isRunning = false;
                });
                widget.gameService.stopTimer();
              } : null,
              child: Text('Pausar'),
            ),
            SizedBox(width: 10),
            // Botón de Reset para cronómetro y cuartos
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isRunning = false;
                  gameEnded = false;
                });
                widget.gameService.resetGame((newTime, newQuarter) {
                  setState(() {
                    time = widget.gameService.formatTime(newTime);
                    currentQuarter = newQuarter;
                  });
                });
              },
              child: Text('Resetear Juego'),
            ),
          ],
        ),
      ],
    );
  }
}