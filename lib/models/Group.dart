import 'package:pocketbase/pocketbase.dart';

class Group extends RecordModel {
  String? name;
  bool? active;
  String? userId;

  Group({this.name, this.active, this.userId});

  static Group fromRecordModal(RecordModel record) {
    Group group = Group(
        name: record.data['name'],
        active: record.data['active'],
        userId: record.data['userId']);
    group.id = record.id;
    group.collectionName = record.collectionName;
    group.expand = record.expand;
    group.created = record.created;
    group.updated = record.updated;
    group.collectionId = record.collectionId;
    return group;
  }
}
