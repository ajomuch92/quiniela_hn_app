import 'PlayerPerLeague.dart';
import 'Tournament.dart';
import 'User.dart';

class League {
  String? id, name, ownerId, tournamentId;
  Tournament? tournament;
  User? owner;
  List<PlayerPerLeague>? players = [];
  bool isMine = false;

  League({this.id, this.name, this.ownerId, this.tournamentId, this.tournament, this.owner, this.players, this.isMine = false});

  factory League.fromJson(Map<String, dynamic> json) {
    User? user;
    if (json['expand']['ownerId'] != null ) {
      user = User.fromJson(json['expand']['ownerId']);
    } else if (json['expand']['leagueId.ownerId'] != null) {
      user = User.fromJson(json['expand']['leagueId.ownerId']);
    }
    return League(
      id: json['id'],
      name: json['name'],
      ownerId: json['ownerId'],
      tournamentId: json['tournamentId'],
      owner: user,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ownerId': ownerId,
      'tournamentId': tournamentId,
    };
  }
}