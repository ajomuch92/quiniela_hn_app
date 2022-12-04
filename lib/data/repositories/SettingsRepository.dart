import 'package:pocketbase/pocketbase.dart';
import 'package:quiniela_hn_app/data/models/Settings.dart';
import 'package:quiniela_hn_app/data/pocketBase.dart';

class SettingsRepository {

  SettingsRepository();

  static Future<Settings> getSettings () async {
    try {
      List<RecordModel> list = await pocketBaseClient.collection('settings').getFullList(expand: 'currentTournamentId');
      if (list.isEmpty) {
        return Settings();
      }
      return Settings.fromJson(list.first.toJson());
    } catch (err) {
      return Settings();
    }
  }
}