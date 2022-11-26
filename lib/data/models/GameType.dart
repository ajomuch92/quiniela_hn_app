class GameType {
  String? id, type;

  GameType({this.id, this.type});

  factory GameType.fromJson(Map<String, dynamic> json) {
    return GameType(
      id: json['id'],
      type: json['type'],
    );
  }
}