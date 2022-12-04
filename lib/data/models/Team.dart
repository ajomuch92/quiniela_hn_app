class Team {
  String? id, name, stadium, city, image;
  int? yearOfBirth;

  Team({this.id, this.name, this.stadium, this.city, this.yearOfBirth, this.image});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      stadium: json['stadium'],
      city: json['city'],
      yearOfBirth: json['yearOfBirth'],
      image: json['image'],
    );
  }
}