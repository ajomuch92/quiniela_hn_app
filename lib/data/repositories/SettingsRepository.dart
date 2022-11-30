import 'package:pocketbase/pocketbase.dart';
import 'package:quiniela_hn_app/data/models/Settings.dart';
import 'package:quiniela_hn_app/data/pocketBase.dart';

class SettingsRepository {

  SettingsRepository();

  static Future<Settings> getSettings () async {
    try {
      ResultList<RecordModel> list = await pocketBaseClient.collection('settings').getList(expand: 'currentTournamentId');
      if (list.items.isEmpty) {
        return Settings();
      }
      return Settings.fromJson(list.items[0].toJson());
    } catch (err) {
      return Settings();
    }
  }
}