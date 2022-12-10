import 'package:pocketbase/pocketbase.dart';

import '../models/User.dart';
import '../pocketBase.dart';

class UserRepository {
  final _pb = pocketBaseClient;

  UserRepository();

  Future<User> updateName(String newName) async {
    try {
      RecordModel recordModel = await _pb.collection('users').update(user.id!, body: {
        'name': newName,
      });
      return User.fromJson(recordModel.toJson());
    } catch (err) {
      rethrow;
    }
  }

  Future<void> updatePassword(User userUpdated) async {
    try {
      await _pb.collection('users').update(user.id!, body: {
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