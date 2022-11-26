class Settings {
  String? id, currentTournamentId;
  int? hitResult, exactMatch, differenceGoals, homeScoreMatch, awayScoreMatch;

  Settings({ this.id, this.currentTournamentId, this.hitResult, this.exactMatch, this.differenceGoals, this.homeScoreMatch, this.awayScoreMatch});

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      id: json['id'],
      currentTournamentId: json['currentTournamentId'],
      hitResult: int.tryParse(json['hitResult']),
      exactMatch: int.tryParse(json['exactMatch']),
      differenceGoals: int.tryParse(json['differenceGoals']),
      homeScoreMatch: int.tryParse(json['homeScoreMatch']),
      awayScoreMatch: int.tryParse(json['awayScoreMatch']),
    );
  }
}