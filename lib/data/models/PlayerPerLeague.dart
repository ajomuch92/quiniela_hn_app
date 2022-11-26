import 'package:quiniela_hn_app/data/models/League.dart';
import 'package:quiniela_hn_app/data/models/User.dart';

class PlayerPerLeague {
  String? id, leagueId, userId;
  User? user;
  League? league;

  PlayerPerLeague({ this.id, this.leagueId, this.userId, this.user, this.league});

  factory PlayerPerLeague.fromJson(Map<String, dynamic> json) {
    return PlayerPerLeague(
      id: json['id'],
      leagueId: json['leagueId'],
      userId: json['userId'],
    );
  }
}