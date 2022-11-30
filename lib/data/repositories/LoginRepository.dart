import 'dart:convert';

import 'package:pocketbase/pocketbase.dart';
import 'package:quiniela_hn_app/data/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pocketBase.dart';

class LoginRepository {
  final _pb = pocketBaseClient;
  late SharedPreferences prefs;

  LoginRepository() {
    loadSharePreference();
  }

  void loadSharePreference() async {
    prefs = await SharedPreferences.getInstance();
  }

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
      RecordAuth auth = await _pb.collection('users').authWithPassword(usernameOrEmail, password);
      await prefs.setString('token', auth.token);
      await prefs.setString('user', jsonEncode(auth.record));
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

  static Future<bool> isValidToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? userEncoded = prefs.getString('user');
    if (token == null || userEncoded == null) return false;
    RecordModel recordModel = RecordModel.fromJson(jsonDecode(userEncoded));
    pocketBaseClient.authStore.save(token, recordModel);
    return pocketBaseClient.authStore.isValid;
  }

  static String token() {
    return pocketBaseClient.authStore.token;
  }
}