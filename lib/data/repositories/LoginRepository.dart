import 'package:quiniela_hn_app/data/models/User.dart';

import '../pocketBase.dart';

class LoginRepository {
  final _pb = pocketBaseClient;

  LoginRepository();

  Future<void> createUser(User user) async {
    try {
      await _pb.collection('users').create(
        body: user.toJsonSignUp(),
      );
    } catch (err) {
      rethrow;
    }
  }

  Future<void> login(String usernameOrEmail, String password) async{
    try {
      await _pb.collection('users').authWithPassword(usernameOrEmail, password);
    } catch (err) {
      rethrow;
    }
  }

  static void logout() {
    try {
      pocketBaseClient.authStore.clear();
    } catch (err) {
      rethrow;
    }
  }

  static bool isValidToken() {
    return pocketBaseClient.authStore.isValid;
  }

  static String token() {
    return pocketBaseClient.authStore.token;
  }
}