import 'package:basketball_real_time_app/widgets/shotclock_widget.dart';
import 'package:flutter/material.dart';
import '../models/team.dart';
import '../widgets/scoreboard_widget.dart';
import '../widgets/timer_widget.dart';
import '../services/game_service.dart';

class MarcadorHomeScreen extends StatelessWidget {
  final Team teamA = Team(name: 'Equipo A');
  final Team teamB = Team(name: 'Equipo B');
  final GameService gameService = GameService();

  @override
  Widget build(BuildContext context) {
    double halfScreenHeight = MediaQuery.of(context).size.height * 0.5;
    return Scaffold(
      body: Flex(
        direction: Axis.vertical, // Horizontal layout
        children: [
          // Widget del Cronómetro
          SizedBox(
            height: halfScreenHeight,
            child: TimerWidget(gameService: gameService, teamA: teamA, teamB: teamB)
          ),
          // Marcador de los equipos
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Pasa el equipo A al widget de marcador
                BasketballScoreboard(team: teamA), // Equipo A
                ShotClockWidget(initialTime: 24), // ShotClock
                BasketballScoreboard(team: teamB), // Equipo B
              ],
            ),
          ),
        ],
      ),
    );
  }
}
