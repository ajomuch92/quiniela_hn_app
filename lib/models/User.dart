import 'package:pocketbase/pocketbase.dart';

class User extends RecordModel {
  String? username;
  String? email;
  String? name;
  String? avatar;

  User({this.username, this.email, this.name, this.avatar});

  static User fromRecordModal(RecordModel record) {
    User user = User(
        name: record.data['name'],
        email: record.data['email'],
        username: record.data['username']);
    user.id = record.id;
    user.collectionName = record.collectionName;
    user.expand = record.expand;
    user.created = record.created;
    user.updated = record.updated;
    user.collectionId = record.collectionId;
    return user;
  }
}
