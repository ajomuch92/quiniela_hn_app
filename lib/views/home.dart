import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:quiniela_hn_app/controllers/HomeController.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home'),
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
                  icon: Icon(Glyphicon.house),
                  title: Text('Inicio'),
                ),
                FlashyTabBarItem(
                  icon: Icon(Icons.score),
                  title: Text('Quiniela'),
                ),
                FlashyTabBarItem(
                  icon: Icon(Icons.person),
                  title: Text('Perfil'),
                ),
              ],
            );
          }
      ),
    );
  }
}
