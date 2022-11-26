class User {
  String? id, name, email, username;

  User({this.id, this.name, this.email, this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
    );
  }
}