import "package:pocketbase/pocketbase.dart";
class User {
  String? id, name, email, username, password, usernameOrEmail, oldPassword, newPassword;

  User({this.id, this.name, this.email, this.username, this.password, this.usernameOrEmail});

  factory User.fromRecord(RecordModel record) => User.fromJson(record.toJson());

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'password': password,
    };
  }

  Map<String, dynamic> toJsonSignUp() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'password': password,
      'passwordConfirm': password,
    };
  }
}