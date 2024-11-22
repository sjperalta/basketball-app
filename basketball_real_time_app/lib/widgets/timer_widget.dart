import 'package:flutter/material.dart';
import '../models/team.dart';
import '../services/game_service.dart';

class TimerWidget extends StatefulWidget {
  final GameService gameService;
  final Team teamA;
  final Team teamB;

  const TimerWidget({super.key, required this.gameService, required this.teamA, required this.teamB});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>
    with SingleTickerProviderStateMixin {
  String time = "12:00";
  bool isRunning = false;
  int currentQuarter = 1;
  bool gameEnded = false;
  
  void resetGame() {
    // Reset the timer
    setState(() {
      time = "12:00";
      isRunning = false;
      currentQuarter = 1;
      gameEnded = false;
    });

    // Reset team scores
    setState(() {
      widget.teamA.resetScore();
      widget.teamB.resetScore();
    });

    widget.gameService.resetGame((newTime, newQuarter) {
      setState(() {
        time = widget.gameService.formatTime(newTime);
        currentQuarter = newQuarter;
      });
    });
  }

  // Animation controller and opacity animation
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller for flashing effect
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Duration for each flashing cycle
    );

    // Define an opacity animation between 0 (invisible) and 1 (fully visible)
    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double responsiveFontSize = screenWidth * 0.20;
    double responsivePeriodFontSize = screenWidth * 0.025;
    
    return Container(
        //color: Colors.green,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Column(
                children: [
                  Text(
                    gameEnded ? 'Juego Finalizado' : 'PERIODO $currentQuarter',
                    style: TextStyle(
                        fontSize: responsivePeriodFontSize,
                        fontFamily: 'Digital',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.0,
                    )
                  ),
                  const SizedBox(height: 5),
                  // Quarter Progress (Indicator)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(
                          Icons.circle,
                          color: index < currentQuarter
                              ? Colors.green
                              : Colors.grey,
                          size: 16,
                        ),
                      );
                    }),
                  ),
                ],
              ),

              // Timer Display with Flashing Effect (Only when paused)
              AnimatedBuilder(
                animation: _opacityAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: isRunning
                        ? 1.0
                        : _opacityAnimation.value, // Flashing only when paused
                    child: Text(
                      time,
                      style: TextStyle(
                        fontSize: responsiveFontSize,
                        height: 1.0,
                        fontFamily: 'Digital', // Add your digital font here
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
              // Control Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Start/Resume Button
                  ElevatedButton.icon(
                    onPressed: isRunning || gameEnded
                        ? null
                        : () {
                            setState(() {
                              isRunning = true;
                            });
                            _controller
                                .stop(); // Stop flashing animation when timer starts
                            widget.gameService.startTimer(
                              (secondsLeft) {
                                setState(() {
                                  time = widget.gameService
                                      .formatTime(secondsLeft);
                                });
                              },
                              (newQuarter) {
                                setState(() {
                                  isRunning = false;
                                  currentQuarter = newQuarter;
                                });
                                widget.gameService
                                    .resetForNextQuarter((newTimeLeft) {
                                  setState(() {
                                    time = widget.gameService
                                        .formatTime(newTimeLeft);
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
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Iniciar'),
                  ),
                  const SizedBox(width: 10),
                  // Pause Button
                  ElevatedButton.icon(
                    onPressed: isRunning
                        ? () {
                            setState(() {
                              isRunning = false;
                            });
                            _controller.repeat(
                                reverse:
                                    true); // Start flashing animation on pause
                            widget.gameService.stopTimer(); // Stop the timer
                          }
                        : null,
                    icon: const Icon(Icons.pause),
                    label: const Text('Pausar'),
                  ),
                  const SizedBox(width: 10),
                  // Reset Button
                  ElevatedButton.icon(
                    onPressed: resetGame,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Resetear'),
                  ),
                ],
            ),
          ]
        )
      );
  }
}
