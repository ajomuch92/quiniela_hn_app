import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:getwidget/getwidget.dart';
import 'package:quiniela_hn_app/data/models/Game.dart';
import 'package:quiniela_hn_app/data/models/GameDay.dart';
import 'package:quiniela_hn_app/domain/home/HomeProvider.dart';
import 'package:quiniela_hn_app/presentation/views/Home/Widgets/Game.dart';

class Tab1 extends ConsumerStatefulWidget {
  const Tab1({Key? key}) : super(key: key);

  @override
  ConsumerState<Tab1> createState() => _Tab1State();
}

class _Tab1State extends ConsumerState<Tab1> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<GameDay> gameDayList = ref.watch(gamesProvider);
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        GameDay gameDay = gameDayList[index];
        List<Game> games = gameDay.games;
        return GFAccordion(
          showAccordion: false,
          title: gameDay.name,
          contentChild: SingleChildScrollView(
            child: Column(
              children: games.map((e) => GameView(game: e)).toList(),
            ),
          )
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(), 
      itemCount: gameDayList.length
    );
  }
}