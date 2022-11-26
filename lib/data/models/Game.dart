import 'package:quiniela_hn_app/data/models/GameDay.dart';
import 'package:quiniela_hn_app/data/models/GameType.dart';
import 'package:quiniela_hn_app/data/models/Team.dart';

class Game {
  String? id, gameDayId, homeTeamId, awayTeamId, gameTypeId, stadium,status;
  int? homeScore, awayScore, homeScorePenalti, awayScorePenalti;
  DateTime? dateTime;

  GameDay? gameDay;
  Team? homeTeam, awayTeam;
  GameType? gameType;

  Game({this.id, this.gameDayId, this.homeTeamId, this.awayTeamId, this.gameTypeId, this.stadium,
    this.homeScore, this.awayScore, this.homeScorePenalti, this.awayScorePenalti, this.status,
    this.dateTime, this.gameDay, this.homeTeam, this.awayTeam, this.gameType
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      gameDayId: json['gameDayId'],
      homeTeamId: json['homeTeamId'],
      awayTeamId: json['awayTeamId'],
      gameTypeId: json['gameTypeId'],
      stadium: json['stadium'],
      status: json['status'],
      homeScore: json['homeScore'],
      awayScore: json['awayScore'],
      homeScorePenalti: json['homeScorePenalti'],
      awayScorePenalti: json['awayScorePenalti'],
      dateTime: DateTime.tryParse(json['dateTime'] ?? '')
    );
  }
}