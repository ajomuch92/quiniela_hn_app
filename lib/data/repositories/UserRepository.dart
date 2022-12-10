import 'package:pocketbase/pocketbase.dart';

import '../models/User.dart';
import '../pocketBase.dart';

class UserRepository {
  final _pb = pocketBaseClient;

  UserRepository();

  Future<void> updateName(String newName) async {
    try {
      await _pb.collection('user').update(user.id!, body: {
        'name': newName,
      });
    } catch (err) {
      rethrow;
    }
  }

  Future<void> updatePassword(User userUpdated) async {
    try {
      await _pb.collection('user').update(user.id!, body: {
        'oldPassword': user.oldPassword,
        'password': user.password,
        'newPassword': user.newPassword,
      });
    } catch (err) {
      rethrow;
    }
  }

  User get user {
    RecordModel recordAuth = _pb.authStore.model;
    return User.fromJson(recordAuth.toJson());
  }
}