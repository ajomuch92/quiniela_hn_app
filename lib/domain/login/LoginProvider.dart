import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiniela_hn_app/data/repositories/LoginRepository.dart';

import '../../data/models/User.dart';

class LoginNotifier extends ChangeNotifier {
  String usernameOrEmail = '';
  String password = '';
  bool passwordEmpty = false;
  bool usernameOrEmailEmpty = false;
  final LoginRepository repository = LoginRepository();

  LoginNotifier(): super();

  Future<void> login() async {
    await repository.login(usernameOrEmail, password);
  }

  Future<void> createUser(Map<String, dynamic> json) async{
    User user = User.fromJson(json);
    await repository.createUser(user);
  }

  void setUserNameOrEmail(String usernameOrEmail) {
    this.usernameOrEmail = usernameOrEmail;
  }

  void setPassword(String password) {
    this.password = password;
  }

  bool validateFields() {
    passwordEmpty = password.isEmpty;
    usernameOrEmailEmpty = usernameOrEmail.isEmpty;
    notifyListeners();
    return usernameOrEmail.isEmpty || password.isEmpty;
  }

  Future<void> logout() async {
    try {
      await repository.logout();
    } catch (err) {
      rethrow;
    }
  }

}

final loginProvider = ChangeNotifierProvider((ref) => LoginNotifier());