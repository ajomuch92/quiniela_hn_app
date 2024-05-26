import 'package:pocketbase/pocketbase.dart';
import 'package:quiniela_hn_app/database/index.dart';

Future<RecordAuth> tryToLogin(String email, String password) async {
  return await pb.collection('users').authWithPassword(email, password);
}

logout() {
  pb.authStore.clear();
}

Future<void> trySignUp(Map<String, dynamic> payload) async {
  await pb.collection('users').create(body: payload);
}
