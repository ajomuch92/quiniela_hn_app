import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiniela_hn_app/data/models/Settings.dart';
import 'package:quiniela_hn_app/data/repositories/SettingsRepository.dart';

class SettingsNotifier extends StateNotifier<Settings> {
  SettingsNotifier() : super(Settings()){
    loadSettings();
  }

  Future<Settings> loadSettings() async {
    state = await SettingsRepository.getSettings();
    return state;
  }

}

final settingProvider = StateNotifierProvider<SettingsNotifier, Settings>((ref) => SettingsNotifier());