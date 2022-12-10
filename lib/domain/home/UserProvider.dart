import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiniela_hn_app/data/models/User.dart';
import 'package:quiniela_hn_app/data/repositories/UserRepository.dart';

class UserNotifier extends StateNotifier<User> {
  UserRepository repository = UserRepository();

  UserNotifier() : super(User()){
    loadSettings();
  }

  void loadSettings() async {
    state = repository.user;
  }

  Future<void> changeName(String newName) async {
    try {
      state = await repository.updateName(newName);
    } catch(ex) {
      rethrow;
    }
  }

  Future<void> updatePassword(User user) async {
    try {
      await repository.updatePassword(user);
    } catch(ex) {
      rethrow;
    }
  }

}

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier());