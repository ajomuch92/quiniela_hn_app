import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:quiniela_hn_app/data/models/League.dart';
import 'package:quiniela_hn_app/domain/home/LeagueProvider.dart';

class Tab2 extends ConsumerStatefulWidget {
  const Tab2({Key? key}) : super(key: key);

  @override
  ConsumerState<Tab2> createState() => _Tab2State();
}

class _Tab2State extends ConsumerState<Tab2> {
  @override
  Widget build(BuildContext context) {
    List<League> leagues = ref.watch(leagueProvider);
    return leagues.isEmpty ? 
    const Center(child: Text('Sin ligas creadas o agregadas', style: TextStyle(color: Colors.black87),),) : 
    ListView.separated(
      itemBuilder: (context, index) => GFListTile(
        titleText: leagues[index].name,
        subTitleText: 'De ${leagues[index].owner!.name}',
        icon: const Icon(Icons.chevron_right),
      ), 
      separatorBuilder: (context, _) => const Divider(), 
      itemCount: leagues.length
    );
  }
}