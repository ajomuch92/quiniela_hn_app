import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:getwidget/getwidget.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:quiniela_hn_app/controllers/HomeController.dart';
import 'package:quiniela_hn_app/widgets/HomeBottomSheetBody.dart';
import 'package:quiniela_hn_app/widgets/HomeList.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final HomeController controller = HomeController();
  final List<String> titles = ['Inicio', 'Predicciones', 'Mi perfil'];

  showBottomSheet(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      elevation: 20,
      expand: true,
      topRadius: const Radius.circular(15),
      
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: HomeBottomSheetBody(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        actions: [
          GFIconButton(
              type: GFButtonType.transparent,
              size: 10,
              icon: const Icon(
                Glyphicon.box_arrow_left,
                color: Colors.white,
              ),
              onPressed: () {
                controller.logoutFn();
                context.replace('/login');
              })
        ],
        title: SignalBuilder(
            signal: controller.selectedIndex,
            builder: (context, value, child) {
              return Text(titles[value]);
            }),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: PageView(
          controller: controller.pageController,
          onPageChanged: controller.changeOnlySelectedIndex,
          children: [
            HomeList(
              resourceGroup: controller.groupsResource,
            ),
            Placeholder(),
            Placeholder(),
          ],
        ),
      ),
      bottomNavigationBar: SignalBuilder(
          signal: controller.selectedIndex,
          builder: (context, value, child) {
            return FlashyTabBar(
              animationCurve: Curves.linear,
              selectedIndex: value,
              iconSize: 30,
              showElevation: false,
              onItemSelected: controller.changeSelectedIndex,
              items: [
                FlashyTabBarItem(
                  icon: const Icon(Glyphicon.house),
                  title: const Text('Inicio'),
                  activeColor: Colors.blueAccent,
                  inactiveColor: Colors.black,
                ),
                FlashyTabBarItem(
                  icon: const Icon(Icons.person),
                  title: const Text('Perfil'),
                  inactiveColor: Colors.black,
                  activeColor: Colors.blueAccent,
                ),
              ],
            );
          }),
    );
  }
}
