import 'package:flutter/material.dart';
import '../models/team.dart';

class BasketballScoreboard extends StatefulWidget {
  final Team team;

  const BasketballScoreboard({super.key, required this.team});

  @override
  _BasketballScoreboardState createState() => _BasketballScoreboardState();
}

class _BasketballScoreboardState extends State<BasketballScoreboard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double responsiveTeamFontSize = screenWidth * 0.03;
    double responsiveScoreFontSize = screenWidth * 0.15;

    return Container(
      // Padding para el panel
      // color: Colors.blue,
      child: Column(
        children: [
          Text(
            widget.team.name,
            style: TextStyle(
                fontSize: responsiveTeamFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
          // Timer and Score in a Row
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (widget.team.score.value > 0) {
                            widget.team.removePoints(1);
                          }
                        });
                      },
                      icon: const Icon(Icons.remove_circle,
                          color: Colors.redAccent),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (widget.team.score.value > 0) {
                            widget.team.removePoints(2);
                          }
                        });
                      },
                      icon: const Icon(Icons.remove_circle,
                          color: Colors.redAccent),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (widget.team.score.value > 0) {
                            widget.team.removePoints(3);
                          }
                        });
                      },
                      icon: const Icon(Icons.remove_circle,
                          color: Colors.redAccent),
                    ),
                  ],
                ),
              ],
            ),
            ValueListenableBuilder<int>(
              valueListenable: widget.team.score,
              builder: (context, value, child) {
                return Text(
                  value.toString(),
                  style: TextStyle(
                      fontSize: responsiveScoreFontSize,
                      fontFamily: 'Digital',
                      color: Colors.yellowAccent),
                );
              },
            ),
            // Buttons to add/remove points
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.team.addPoints(1);
                    });
                  },
                  icon: const Icon(Icons.add_circle, color: Colors.greenAccent),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.team.addPoints(2);
                    });
                  },
                  icon: const Icon(Icons.add_circle, color: Colors.greenAccent),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.team.addPoints(3);
                    });
                  },
                  icon: const Icon(Icons.add_circle, color: Colors.greenAccent),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Faltas',
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Digital',
                      color: Colors.redAccent),
                  textAlign: TextAlign.center,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ValueListenableBuilder<int>(
                        valueListenable: widget.team.fouls,
                        builder: (context, value, child) {
                          return Text(
                            value.toString(),
                            style: const TextStyle(
                                fontSize: 90,
                                fontFamily: 'Digital',
                                color: Colors.yellowAccent),
                          );
                        },
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                widget.team.addFoul();
                              });
                            },
                            icon: const Icon(Icons.add_circle,
                                color: Colors.redAccent),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (widget.team.fouls.value > 0) {
                                  widget.team.removeFoul();
                                }
                              });
                            },
                            icon: const Icon(Icons.remove_circle,
                                color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ])
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
