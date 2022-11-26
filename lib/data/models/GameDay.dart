import 'package:quiniela_hn_app/data/models/tournament.dart';

class GameDay {
  String? id, name, tournamentId;
  DateTime? startDate;
  Tournament? tournament;
  
  GameDay({this.id, this.name, this.tournamentId, this.startDate, this.tournament});
  
  factory GameDay.fromJson(Map<String, dynamic> json) {
    return GameDay(
      id: json['id'],
      name: json['name'],
      tournamentId: json['tournamentId'],
      startDate: DateTime.tryParse(json['startDate'] ?? '')
    );
  }
}