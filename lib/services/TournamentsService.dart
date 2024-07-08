import 'package:pocketbase/pocketbase.dart';
import 'package:quiniela_hn_app/database/index.dart';
import 'package:quiniela_hn_app/models/Tournament.dart';

Future<List<Tournament>> getTournaments(String? filter) async {
  List<RecordModel> list =
      await pb.collection('tournaments').getFullList(filter: filter);
  return list.map((el) => Tournament.fromRecordModal(el)).toList();
}
