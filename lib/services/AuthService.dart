import 'package:quiniela_hn_app/database/index.dart';

Future<void> tryToLogin(String email, String password) async {
  await pb.collection('users').authWithPassword(email, password);
}

logout() {
  pb.authStore.clear();
}
