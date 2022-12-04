import 'package:pocketbase/pocketbase.dart';
import 'package:quiniela_hn_app/data/models/Game.dart';
import 'package:quiniela_hn_app/data/models/GameDay.dart';
import 'package:quiniela_hn_app/data/models/PredictionPerGame.dart';
import 'package:quiniela_hn_app/data/pocketBase.dart';

class GameRepository {
  final _pb = pocketBaseClient;

  Future<List<GameDay>> getListGameDays(String tournamentId, void Function(RecordSubscriptionEvent) callback) async {
    List<GameDay> listGameDays = [];
    List<RecordModel> gameDays = await _pb.collection('gameDays').getFullList(filter: 'tournamentID="$tournamentId"', expand: 'games(gameDayId), games(gameDayId).homeTeamId, games(gameDayId).awayTeamId, games(gameDayId).gameTypeId');
    for(RecordModel gameDay in gameDays) {
      List<RecordModel>? gameDayRecordModelList = gameDay.expand['games(gameDayId)'];
      Map<String, dynamic> gameDayJson = gameDay.toJson();
      GameDay currentGameDay = GameDay.fromJson(gameDayJson);
      if (gameDayRecordModelList != null) {
        for(RecordModel gameDayRecordModel in gameDayRecordModelList) {
          Game currentGame = Game.fromJson(gameDayRecordModel.toJson());
          if (currentGame.awayTeam != null && currentGame.homeTeam != null) {
            RecordModel imageRecordModel = gameDayRecordModel.expand['awayTeamId']!.first;
            currentGame.awayTeam?.image = _pb.getFileUrl(imageRecordModel, currentGame.awayTeam!.image!, thumb: '100x100').toString();
            imageRecordModel = gameDayRecordModel.expand['homeTeamId']!.first;
            currentGame.homeTeam?.image = _pb.getFileUrl(imageRecordModel, currentGame.homeTeam!.image!, thumb: '100x100').toString();
          }
          currentGameDay.games.add(currentGame);
        }
      }
      listGameDays.add(currentGameDay);
    }
    _pb.collection('games').subscribe('*', callback);
    return listGameDays;
  }

  Future<List<GameDay>> getListGames(String tournamentId, String currentGameDayId, void Function(RecordSubscriptionEvent) callback) async {
    try {
      List<GameDay> listGameDays = await getListGameDays(tournamentId, callback);
      for(GameDay gameDay in listGameDays) {
        if (gameDay.id == currentGameDayId) {
          for(Game game in gameDay.games) {
            game.prediction = await getPrediction(game.id!);
          }
        }
      }
      return listGameDays;
    } catch (err) {
      rethrow;
    }
  }

  Future<PredictionPerGame> getPrediction(String gameId) async {
    try {
      RecordModel recordModel = await _pb.collection('predictionPerGame').getFirstListItem('gameId="$gameId" && userId="$userId"');
      return PredictionPerGame.fromJson(recordModel.toJson());
    } on ClientException catch(ex) {
      return PredictionPerGame();
    } catch (ex) {
      rethrow;
    }
  }

  Future<PredictionPerGame?> savePrediction(PredictionPerGame prediction, {bool update = false}) async {
    try {
      prediction.userId = userId;
      RecordModel recordModel;
      if (update) {
        recordModel = await _pb.collection('predictionPerGame').update(prediction.id!, body: prediction.toJson());
      } else {
        recordModel = await _pb.collection('predictionPerGame').create(
          body: prediction.toJson(),
        );
      }
      return PredictionPerGame.fromJson(recordModel.toJson());
    } catch (ex) {
      rethrow;
    }
  }

  Future<void> removeListeners() async {
    await _pb.collection('games').unsubscribe();
  }

  String get userId {
    RecordModel recordAuth = _pb.authStore.model;
    return recordAuth.id;
  }
}