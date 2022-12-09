import 'package:pocketbase/pocketbase.dart';
import 'package:quiniela_hn_app/data/models/League.dart';
import 'package:quiniela_hn_app/data/models/PlayerPerLeague.dart';
import 'package:quiniela_hn_app/data/pocketBase.dart';
import '../../presentation/utils/extensions.dart';

class LeagueRepository {
  final _pb = pocketBaseClient;

  Future<List<League>> loadLeagues() async {
    try {
      List<RecordModel> recordModelList = await _pb.collection('playersPerLeague').getFullList(
        filter: 'userId="$userId"',
        expand: 'leagueId, userId, leagueId.ownerId'
      );
      List<PlayerPerLeague> playersPerLeagueList = recordModelList.map((e) => PlayerPerLeague.fromJson(e.toJson())).toList();
      List<League> leagues = playersPerLeagueList.map((e) => e.league ?? League()).toList();
      leagues = leagues.unique((e) => e.id);
      for(League league in leagues) {
        league.players = playersPerLeagueList.where((element) => element.leagueId == league.id).toList();
        league.isMine = league.ownerId == userId;
      }
      return leagues;
    } catch(ex) {
      rethrow;
    }
  }

  Future<void> createLeague(String leagueName, String tournamentId) async {
    try {
      League league = League(name: leagueName, ownerId: userId, tournamentId: tournamentId);
      RecordModel recordModel = await _pb.collection('leagues').create(
        body: league.toJson(),
      );
      league = League.fromJson(recordModel.toJson());
      await _pb.collection('playersPerLeague').create(
        body: {
          'leagueId': league.id,
          'userId': userId,
        }
      );
    } catch (ex) {
      rethrow;
    }
  }

  Future<void> joinLeague(String leagueId) async{
    try {
      await _pb.collection('playersPerLeague').getFirstListItem('leagueId="$leagueId"&&userId="$userId"');
      throw AssertionError('You have already joined to this league');
    } on ClientException catch(_) {
      await _pb.collection('playersPerLeague').create(
        body: {
          'leagueId': leagueId,
          'userId': userId,
        }
      );
      rethrow;
    } catch (err) {
      rethrow;
    }
  }

  String get userId {
    RecordModel recordAuth = _pb.authStore.model;
    return recordAuth.id;
  }
}