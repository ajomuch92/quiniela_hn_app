import 'package:pocketbase/pocketbase.dart';
import 'package:quiniela_hn_app/models/Group.dart';
import 'package:quiniela_hn_app/models/User.dart';

class UsersPerGroup extends RecordModel {
  String? userId;
  String? groupId;
  Group? group;
  User? user;

  UsersPerGroup({this.userId, this.user, this.group, this.groupId});

  static UsersPerGroup fromRecordModal(RecordModel record) {
    UsersPerGroup usersPerGroup = UsersPerGroup(
        groupId: record.data['groupId'], userId: record.data['userId']);
    usersPerGroup.id = record.id;
    usersPerGroup.collectionName = record.collectionName;
    usersPerGroup.expand = record.expand;
    usersPerGroup.created = record.created;
    usersPerGroup.updated = record.updated;
    usersPerGroup.collectionId = record.collectionId;
    if (record.expand['groupId'] != null) {
      usersPerGroup.group = Group.fromRecordModal(
          (record.expand['groupId'] as List<RecordModel>)[0]);
    }
    if (record.expand['userId'] != null) {
      usersPerGroup.user = User.fromRecordModal(
          (record.expand['userId'] as List<RecordModel>)[0]);
    }
    return usersPerGroup;
  }
}
