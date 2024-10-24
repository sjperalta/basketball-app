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
    return Scaffold(
      appBar: AppBar(
        title: Text('Marcador en Tiempo Real'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Widget del Cronómetro
          TimerWidget(gameService: gameService),
          SizedBox(height: 20),
          // Marcador de los equipos
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Pasa el equipo A al widget de marcador
              Expanded(
                child: BasketballScoreboard(team: teamA), // Equipo A
              ),
              Expanded(
                child: BasketballScoreboard(team: teamB), // Equipo B
              ),
            ],
          ),
        ],
      ),
    );
  }
}