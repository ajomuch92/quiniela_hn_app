import 'dart:async';
import 'dart:ffi';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:quiniela_hn_app/data/models/Game.dart';
import 'package:quiniela_hn_app/data/models/GameDay.dart';
import 'package:quiniela_hn_app/data/models/PredictionPerGame.dart';
import 'package:quiniela_hn_app/data/repositories/GameRepository.dart';

class GamesNotifier extends StateNotifier<List<GameDay>> {
  final GameRepository repository = GameRepository();

  GamesNotifier(): super([]);

  @override
  void dispose() async {
    await repository.removeListeners();
    super.dispose();
  }

  Future<void> loadGames(String tournamentID, String currentGameDayId) async {
    try {
      state = await repository.getListGames(tournamentID, currentGameDayId, _callbackSuscribe);
    } catch (err) {
      rethrow;
    }
  }

  Future<void> savePrediction(PredictionPerGame prediction, {bool update = false}) async{
    try {
      PredictionPerGame? predictionUpdated = await repository.savePrediction(prediction, update: update);
      if (predictionUpdated == null) return;
      for (GameDay gameDay in state) {
        for (Game game in gameDay.games) {
          if (game.id == prediction.gameId) {
            game.prediction = predictionUpdated;
          }
        }
      }
      state = [...state];
    } catch (err) {
      rethrow;
    }
  }

  void _callbackSuscribe(RecordSubscriptionEvent e) {
    if (e.action == 'update' && e.record != null) {
      Game gameUpdated = Game.fromJson(e.record!.toJson());
      for (GameDay gameDay in state) {
        for (Game game in gameDay.games) {
          if (game.id == gameUpdated.id) {
            game.awayScore = gameUpdated.awayScore;
            game.awayScorePenalti = gameUpdated.awayScorePenalti;
            game.homeScore = gameUpdated.homeScore;
            game.homeScorePenalti = gameUpdated.homeScorePenalti;
            game.dateTime = gameUpdated.dateTime;
            game.status = gameUpdated.status;
          }
        }
      }
      state = [...state];
    }
  }

}

final gamesProvider = StateNotifierProvider<GamesNotifier, List<GameDay>>((ref) => GamesNotifier());

class TimerNotifier extends StateNotifier<DateTime> {
  late Timer _timer;

  TimerNotifier() : super(DateTime.now()) {
    _timer = Timer(const Duration(minutes: 1), () {
      state = DateTime.now();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, DateTime>((ref) => TimerNotifier());