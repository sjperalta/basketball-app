import 'package:flutter/widgets.dart';

class Team {
  String name;
  ValueNotifier<int> score = ValueNotifier<int>(0);
  ValueNotifier<int> fouls = ValueNotifier<int>(0);  // Nuevo campo para contar faltas

  Team({required this.name });

  void addPoints(int points) {
    score.value += points;
  }

  void removePoints(int points) {
    score.value = (score.value - points >= 0) ? score.value - points : 0;  // Evitar puntaje negativo
  }

  void addFoul() {
    fouls.value += 1;
  }

  void removeFoul() {
    fouls.value = (fouls.value - 1 >= 0) ? fouls.value - 1 : 0;  // Evitar faltas negativas
  }

  void resetScore(){
    score.value = 0;
    fouls.value = 0;
  }
}