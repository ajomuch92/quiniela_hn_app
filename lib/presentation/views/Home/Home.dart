import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:quiniela_hn_app/presentation/views/Home/Tab1.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: GFAppBar(
        leading:  GFIconButton(
          icon: const Icon(
            Glyphicon.list,
            color: Colors.white,
          ),
          onPressed: () {},
          type: GFButtonType.transparent,
        ),
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
                Center(
                  child: Text('Tab 2'),
                ),
              ]
            )
          ],
        ),
      ),
    );
  }
}