import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:quiniela_hn_app/data/models/Settings.dart';
import 'package:quiniela_hn_app/domain/home/LeagueProvider.dart';
import 'package:quiniela_hn_app/domain/home/SettingsProvider.dart';
import 'package:quiniela_hn_app/presentation/utils/index.dart';
import 'package:quiniela_hn_app/presentation/views/Home/Tab1.dart';
import 'package:quiniela_hn_app/presentation/views/Home/Tab2.dart';
import 'package:quiniela_hn_app/presentation/views/Home/Widgets/CustomDrawer.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with TickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
       selectedIndex = tabController.index; 
      });
    });
  }

  @override
  void dispose() {
    tabController.removeListener(() { });
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset : false,
      drawer: const CustomDrawer(),
      appBar: GFAppBar(
        searchBar: false,
        title: const Text('Quiniela Liga HN'),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        height: size.height,
        child: Column(
          children: [
            GFSegmentTabs(
              tabController: tabController,
              tabBarColor: GFColors.LIGHT,
              labelColor: GFColors.WHITE,
              unselectedLabelColor: GFColors.DARK,
              width: size.width * 0.9,
              indicator: const BoxDecoration(
                color: GFColors.DARK,
              ),
              border: Border.all(color: Colors.white, width: 1.0),
              length: 2,
              tabs: const [
                Text(
                  'Pronosticos',
                ),
                Text(
                  'Mis ligas',
                ),
              ],
            ),
            GFTabBarView(
              controller: tabController, 
              height: size.height * 0.82,
              children: const [
                Tab1(),
                Tab2(),
              ]
            )
          ],
        ),
      ),
      floatingActionButton: selectedIndex == 0 ? null :AnimatedFloatingActionButton(
          //Fab list
          durationAnimation: 180,
          fabButtons: <Widget>[
              FloatingActionButton(
                mini: true,
                tooltip: 'Crea tu liga',
                child: const Icon(Icons.add),
                onPressed: () {
                  showNewLeagueModal(context);
                }
              ),
              FloatingActionButton(
                mini: true,
                tooltip: 'Unete a una liga',
                child: const Icon(Glyphicon.node_plus_fill),
                onPressed: () {
                  showJoinLeagueModal(context);
                }
              ),
          ],
          key : UniqueKey(),
          colorStartAnimation: Colors.blue,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close //To principal button
      ),
    );
  }

  void showNewLeagueModal(BuildContext context) {
    String leagueName = '';
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        alignment: Alignment.center,
        title: const Text('Crea tu liga'),
        content: Container(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Nombra tu liga'),
            ),
            onChanged: (val) {
              leagueName = val;
            },
          ),
        ),
        actions: [
          GFButton(
            onPressed: (){ 
              Navigator.pop(context);
            },
            color: GFColors.LIGHT,
            shape: GFButtonShape.pills,
            child: const Text('Salir', style: TextStyle(color: Colors.black)),
          ),
          const SizedBox(width: 5.0,),
          GFButton(
            onPressed: (){ 
              createLeague(leagueName);
            },
            color: Colors.blueAccent,
            shape: GFButtonShape.pills,
            text: 'Crear',
          )
        ],
      ),
    );
  }

  void createLeague(String leagueName) async {
    try {
      if (leagueName.isEmpty) {
        if (!mounted) return;
        showToast(context, 'El nombre de la liga no debe ir en blanco', ToastType.warning);
        return;
      }
      Settings settings = ref.read(settingProvider);
      final leagueNotifier = ref.read(leagueProvider.notifier);
      await leagueNotifier.createLeague(leagueName, settings.currentTournamentId!);
      if (!mounted) return;
      showToast(context, 'Liga creada con exitosamente', ToastType.success);
      Navigator.pop(context);
    } catch(ex) {
      if (!mounted) return;
      showToast(context, 'Hubo un error al crear tu liga', ToastType.danger);
    }
  }

  void showJoinLeagueModal(BuildContext context) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        alignment: Alignment.center,
        title: const Text('Unete a una liga'),
        content: Container(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: const Text('Codigo de liga'),
              helperText: 'Pega tu codigo',
              suffix: IconButton(
                onPressed: () {
                  FlutterClipboard.paste().then((value) {
                    if (value.isNotEmpty) {
                      controller.text = value;
                    }
                  });
                }, 
                icon: const Icon(Glyphicon.clipboard, color: GFColors.LIGHT,)
              )
            ),
          ),
        ),
        actions: [
          GFButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: GFColors.LIGHT,
            shape: GFButtonShape.pills,
            child: const Text('Salir', style: TextStyle(color: Colors.black)),
          ),
          const SizedBox(width: 5.0,),
          GFButton(
            onPressed: (){ 
              joinLeague(controller.text);
            },
            color: Colors.blueAccent,
            shape: GFButtonShape.pills,
            text: 'Unirse',
          )
        ],
      ),
    );
  }

  void joinLeague(String leagueId) async {
    try {
      if (leagueId.isEmpty) {
        if (!mounted) return;
        showToast(context, 'El codigo de la liga no debe ir en blanco', ToastType.warning);
        return;
      }
      final leagueNotifier = ref.read(leagueProvider.notifier);
      await leagueNotifier.joinLeague(leagueId);
    } on ClientException catch(_) {
      if (!mounted) return;
      showToast(context, 'Liga creada con exitosamente', ToastType.success);
      Navigator.pop(context);
    } on AssertionError catch(_) {
      if (!mounted) return;
      showToast(context, 'Ya te has unido a esta liga', ToastType.warning);
    } catch(ex) {
      if (!mounted) return;
      showToast(context, 'Hubo un error al unirse', ToastType.danger);
    }
  }
}