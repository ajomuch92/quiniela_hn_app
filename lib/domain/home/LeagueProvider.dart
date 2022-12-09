import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiniela_hn_app/data/models/League.dart';
import 'package:quiniela_hn_app/data/repositories/LeagueRepository.dart';

class LeagueNotifer extends StateNotifier<List<League>> {
  final LeagueRepository repository = LeagueRepository();
  LeagueNotifer() : super([]);

  Future<void> loadLeagues() async {
    try {
      state = await repository.loadLeagues();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> createLeague(String leagueName, String tournamentId) async {
    try {
      await repository.createLeague(leagueName, tournamentId);
      await loadLeagues();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> joinLeague(String leagueId) async {
    try {
      await repository.joinLeague(leagueId);
      await loadLeagues();
    } catch (err) {
      rethrow;
    }
  }
}

final leagueProvider = StateNotifierProvider<LeagueNotifer, List<League>>((ref) => LeagueNotifer());