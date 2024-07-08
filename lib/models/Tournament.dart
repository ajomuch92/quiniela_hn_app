import 'package:pocketbase/pocketbase.dart';

class Tournament extends RecordModel {
  String? name;
  String? description;
  bool? active;
  int? resultPoints;
  int? localGoalsPoints;
  int? awayGoalsPoints;
  int? goalsDifferencePoints;
  int? firstTeamToScorePoints;
  String? nextGameDayId;

  Tournament(
      {this.name,
      this.description,
      this.active,
      this.resultPoints,
      this.localGoalsPoints,
      this.awayGoalsPoints,
      this.goalsDifferencePoints,
      this.firstTeamToScorePoints,
      this.nextGameDayId});

  static Tournament fromRecordModal(RecordModel record) {
    Tournament tournament = Tournament(
        name: record.data['name'],
        description: record.data['description'],
        active: record.data['active'],
        resultPoints: record.data['resultPoints'],
        localGoalsPoints: record.data['localGoalsPoints'],
        awayGoalsPoints: record.data['awayGoalsPoints'],
        goalsDifferencePoints: record.data['goalsDifferencePoints'],
        firstTeamToScorePoints: record.data['firstTeamToScorePoints'],
        nextGameDayId: record.data['nextGameDayId']);
    return copyValues<Tournament>(record, tournament);
  }
}

T copyValues<T>(RecordModel origin, RecordModel destiny) {
  destiny.id = origin.id;
  destiny.collectionName = origin.collectionName;
  destiny.expand = origin.expand;
  destiny.created = origin.created;
  destiny.updated = origin.updated;
  destiny.collectionId = origin.collectionId;
  return destiny as T;
}
