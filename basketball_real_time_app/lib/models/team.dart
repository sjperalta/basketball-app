class Team {
  String name;
  int score;
  int fouls; // Nuevo campo para contar faltas

  Team({required this.name, this.score = 0, this.fouls = 0});

  void addPoints(int points) {
    score += points;
  }

  void removePoints(int points) {
    score = (score - points >= 0) ? score - points : 0;  // Evitar puntaje negativo
  }

  void addFoul() {
    fouls += 1;
  }

  void removeFoul() {
    fouls = (fouls - 1 >= 0) ? fouls - 1 : 0;  // Evitar faltas negativas
  }
}