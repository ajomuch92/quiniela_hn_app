import 'package:quiniela_hn_app/data/models/Game.dart';
import 'package:quiniela_hn_app/data/models/User.dart';

class PredictionPerGame {
  String? id, gameId, userId;
  int? homeScore, awayScore;
  bool? joker;

  Game? game;
  User? user;

  PredictionPerGame({ this.id, this.gameId, this.userId, this.homeScore, this.awayScore, this.game, this.user, this.joker});

  factory PredictionPerGame.fromJson(Map<String, dynamic> json) {
    return PredictionPerGame(
      id: json['id'],
      gameId: json['gameId'],
      userId: json['userId'],
      homeScore: json['homeScore'],
      awayScore: json['awayScore'],
      joker: json['joker']
    );
  }
}