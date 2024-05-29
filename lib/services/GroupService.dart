import 'package:pocketbase/pocketbase.dart';
import 'package:quiniela_hn_app/database/index.dart';
import 'package:quiniela_hn_app/models/Group.dart';
import 'package:quiniela_hn_app/models/UsersPerGroup.dart';

Future<List<Group>> getGroups(String? filter) async {
  List<RecordModel> list = await pb
      .collection('groups')
      .getFullList(filter: filter, expand: 'usersPerGroup.groupId, userId');
  return list.map((el) => Group.fromRecordModal(el)).toList();
}

Future<List<Group>> getUniqueGroups(String filter) async {
  List<RecordModel> list = await pb
      .collection('usersPerGroup')
      .getFullList(filter: filter, expand: 'groupId, userId');
  List<UsersPerGroup> userPerGroupList =
      list.map((el) => UsersPerGroup.fromRecordModal(el)).toList();
  List<Group> result = [];
  for (int i = 0; i < userPerGroupList.length; i++) {
    UsersPerGroup item = userPerGroupList[i];
    if (item.group != null && !result.any((el) => el.id == item.group?.id)) {
      result.add(item.group!);
    }
  }
  return result;
}
