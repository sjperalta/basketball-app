import 'package:flutter/material.dart';
import '../models/team.dart';

class BasketballScoreboard extends StatefulWidget {
  final Team team;

  BasketballScoreboard({required this.team});

  @override
  _BasketballScoreboardState createState() => _BasketballScoreboardState();
}

class _BasketballScoreboardState extends State<BasketballScoreboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16), // Padding para el panel
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Alineación
        children: [
          // Nombre del equipo
          Text(
            widget.team.name,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          // Marcador de puntos
          Center(
            child: Text(
              widget.team.score.toString(),
              style: TextStyle(fontSize: 80, color: Colors.yellowAccent, fontFamily: 'Digital'),
            ),
          ),
          SizedBox(height: 20),
          // Botones para sumar y restar puntos
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.team.addPoints(1);
                  });
                },
                icon: Icon(Icons.add_circle, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (widget.team.score > 0) widget.team.removePoints(1);
                  });
                },
                icon: Icon(Icons.remove_circle, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Contador de faltas
          Text(
            'Faltas: ${widget.team.fouls}',
            style: TextStyle(fontSize: 24, color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          // Botones para sumar y restar faltas
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.team.addFoul();
                  });
                },
                icon: Icon(Icons.add_circle, color: Colors.redAccent),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (widget.team.fouls > 0) widget.team.removeFoul();
                  });
                },
                icon: Icon(Icons.remove_circle, color: Colors.redAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}