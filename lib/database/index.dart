import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

late PocketBase pb;

Future<void> setCustomStore() async {
  final prefs = await SharedPreferences.getInstance();

  final store = AsyncAuthStore(
      save: (String token) async {
        await prefs.setString('pb_auth', token);
      },
      clear: () async {
        await prefs.remove('pb_auth');
      },
      initial: prefs.getString('pb_auth'));
  pb = PocketBase('https://quiniela-hn.pockethost.io/', authStore: store);
}
