class Tournament{
  String? id;
  String? name;

  Tournament({this.id, this.name});

  factory Tournament.fromCustomJson(Map<String, dynamic> json) {
    return Tournament(
      id: json['id'],
      name: json['name'],
    );
  }
}