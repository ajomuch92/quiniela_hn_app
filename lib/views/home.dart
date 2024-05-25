import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:glyphicon/glyphicon.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home'),
      ),
      bottomNavigationBar: FlashyTabBar(
        animationCurve: Curves.linear,
        iconSize: 30,
        showElevation: false, // use this to remove appBar's elevation
        onItemSelected: (index) => {},
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
      ),
    );
  }
}
