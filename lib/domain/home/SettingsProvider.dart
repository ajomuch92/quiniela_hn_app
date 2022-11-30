import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiniela_hn_app/data/models/Settings.dart';
import 'package:quiniela_hn_app/data/repositories/SettingsRepository.dart';

class SettingsNotifier extends StateNotifier<Settings> {
  SettingsNotifier() : super(Settings()){
    loadSettings();
  }

  Future<void> loadSettings() async {
    state = await SettingsRepository.getSettings();
  }

}

final settingProvider = StateNotifierProvider<SettingsNotifier, Settings>((ref) => SettingsNotifier());