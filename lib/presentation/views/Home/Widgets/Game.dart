import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:intl/intl.dart';
import 'package:quiniela_hn_app/data/models/Game.dart';
import 'package:quiniela_hn_app/domain/home/HomeProvider.dart';
import 'package:quiniela_hn_app/presentation/utils/Debouncer.dart';
import 'package:quiniela_hn_app/presentation/utils/index.dart';

class GameCard extends ConsumerStatefulWidget {
  final Game game;
  const GameCard({Key? key, required this.game}) : super(key: key);

  @override
  ConsumerState<GameCard> createState() => _GameViewState();
}

class _GameViewState extends ConsumerState<GameCard> {
  late Game game;
  final f = DateFormat('dd/MM/yyyy hh:mm a');
  Debouncer debouncer1 = Debouncer(milliseconds: 300);
  Debouncer debouncer2 = Debouncer(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    game = widget.game;
  }

  @override
  void dispose() {
    debouncer1.dispose();
    debouncer2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = ref.watch(timerProvider);
    bool isLessThan5Minutes = game.dateTime != null ?  game.dateTime!.difference(now).inMinutes < 5: false;
    bool isReadyToMakePrediction = game.status == 'not played';
    return GFCard(
      content: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  game.homeTeam!.name!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ),
              Expanded(flex: 1, child: Container(),),
              Expanded(
                flex: 2,
                child: Text(
                  game.awayTeam!.name!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: 100, 
                  height: 100,
                  child: CachedNetworkImage(
                      imageUrl:  game.homeTeam!.image!,
                      placeholder: (context, url) => const LinearProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red,),
                  ),
                ),
              ),
              const Expanded(flex: 1, child: Center(child: Text('VS'),)),
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: 100, 
                  height: 100, 
                  child: CachedNetworkImage(
                      imageUrl:  game.awayTeam!.image!,
                      placeholder: (context, url) => const LinearProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red,),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10,),
          !isLessThan5Minutes && isReadyToMakePrediction ?
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SpinBox(
                  min: 0,
                  max: 15,
                  value: double.tryParse(game.prediction!.homeScore.toString()) ?? 0,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    debouncer1.run(() {
                      game.prediction!.homeScore = value.toInt();
                      savePrediction(context);
                    });
                  },
                )
              ),
              Expanded(
                flex: 2,
                child: SpinBox(
                  min: 0,
                  max: 15,
                  value: double.tryParse(game.prediction!.awayScore.toString()) ?? 0,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    debouncer2.run(() {
                      game.prediction!.awayScore = value.toInt();
                      savePrediction(context);
                    });
                  },
                )
              )
            ],
          ) :
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  game.prediction!.homeScore.toString(),
                  textAlign: TextAlign.center,
                )
              ),
              Expanded(flex: 1, child: Container(),),
              Expanded(
                flex: 2,
                child: Text(
                  game.prediction!.awayScore.toString(),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          Center(
            child: Chip(
              label: Text('${game.homeScore} - ${game.awayScore}'), 
              backgroundColor: game.status == 'playing' ? Colors.orangeAccent : Colors.lightBlueAccent
            ),
          ),
          Text(game.gameType!.type!),
          Text(game.stadium ?? 'Estadio sin especificar'),
          Text(f.format(game.dateTime!)),
        ],
      ),
    );
  }

  void savePrediction(BuildContext context) async {
    final notifier = ref.read(gamesProvider.notifier);
    try {
      if (game.prediction!.id == null) {
        game.prediction!.gameId = game.id;
        game.prediction!.awayScore ??= 0;
        game.prediction!.homeScore ??= 0;
        await notifier.savePrediction(game.prediction!);
      } else {
        await notifier.savePrediction(game.prediction!, update: true);
      }
      if (!mounted) return;
      showToast(context, 'Resultado guardado', ToastType.success);
    } catch (ex) {
      print(ex.toString());
    }
  }
}