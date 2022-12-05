import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:quiniela_hn_app/data/models/Game.dart';
import 'package:quiniela_hn_app/data/models/GameDay.dart';
import 'package:quiniela_hn_app/data/models/Settings.dart';
import 'package:quiniela_hn_app/domain/home/HomeProvider.dart';
import 'package:quiniela_hn_app/domain/home/SettingsProvider.dart';
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
    Settings settings = ref.watch(settingProvider);
    String currentGameDayId = ref.watch(currentGameIdProvider);
    if (currentGameDayId.isEmpty) currentGameDayId = settings.currentGameDayId!;
    List<Game> games = ref.watch(gameListProvider);
    if (games.isEmpty) {
      int index = gameDayList.indexWhere((element) => element.id == currentGameDayId);
      games = index != -1 ? gameDayList[index].games : [];
    }
    return Column(
      children: [
        const SizedBox(height: 10,),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          child: DropdownButtonHideUnderline(
            child: GFDropdown(
              padding: const EdgeInsets.all(15),
              borderRadius: BorderRadius.circular(5),
              border: const BorderSide(color: Colors.black12, width: 1),
              dropdownButtonColor: Colors.white,
              value: currentGameDayId,
              onChanged: (newValue) {
                String newValueString = newValue as String;
                ref.read(currentGameIdProvider.notifier).setText(newValueString);
                int index = gameDayList.indexWhere((element) => element.id == newValueString);
                ref.read(gameListProvider.notifier).setList(index != -1 ? gameDayList[index].games : []);
              },
              items: gameDayList
                  .map((value) => DropdownMenuItem(
                value: value.id,
                child: Text(value.name!),
              )).toList(),
            ),
          ),
        ),
        const SizedBox(height: 10,),
        games.isNotEmpty ? Expanded(
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              Game currentGame = games[index];
              return GameCard(game: currentGame, key: Key(currentGame.id!),);
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(), 
            itemCount: games.length,
          ),
        ) :
        const Text('Selecciones una jornada para mostrar sus partidos', style: TextStyle(color: Colors.black87), textAlign: TextAlign.center,)
      ],
    );
  }
}