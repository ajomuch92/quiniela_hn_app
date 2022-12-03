class Settings {
  String? id, currentTournamentId, currentGameDayId;
  int? hitResult, exactMatch, differenceGoals, homeScoreMatch, awayScoreMatch;

  Settings({ this.id, this.currentTournamentId, this.hitResult, this.exactMatch, this.differenceGoals, this.homeScoreMatch, this.awayScoreMatch, this.currentGameDayId});

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      id: json['id'],
      currentTournamentId: json['currentTournamentId'],
      hitResult: json['hitResult'],
      exactMatch: json['exactMatch'],
      differenceGoals: json['differenceGoals'],
      homeScoreMatch: json['homeScoreMatch'],
      awayScoreMatch: json['awayScoreMatch'],
      currentGameDayId: json['currentGameDayId'],
    );
  }
}