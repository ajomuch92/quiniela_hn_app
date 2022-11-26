import 'PlayerPerLeague.dart';
import 'Tournament.dart';
import 'User.dart';

class League {
  String? id, name, ownerId, tournamentId;
  Tournament? tournament;
  User? owner;
  List<PlayerPerLeague>? players;

  League({this.id, this.name, this.ownerId, this.tournamentId, this.tournament, this.owner, this.players});

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      name: json['name'],
      ownerId: json['ownerId'],
      tournamentId: json['tournamentId'],
    );
  }
}