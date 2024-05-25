import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:go_router/go_router.dart';
import 'package:quiniela_hn_app/controllers/LoginController.dart';
import 'package:quiniela_hn_app/widgets/LoginForm.dart';
import 'package:tab_container/tab_container.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final LoginController controller = LoginController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      controller.setActiveTab(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: TabContainer(
              controller: _tabController,
              tabEdge: TabEdge.bottom,
              tabsStart: 0.1,
              tabsEnd: 0.9,
              tabMaxLength: 100,
              borderRadius: BorderRadius.circular(10),
              tabBorderRadius: BorderRadius.circular(10),
              childPadding: const EdgeInsets.all(20.0),
              selectedTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
              unselectedTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 13.0,
              ),
              colors: const [
                Colors.green,
                Colors.blueAccent,
              ],
              tabs: const [
                Text('Ingresa'),
                Text('Regístrate'),
              ],
              child: SignalBuilder(
                  signal: controller.activeTab,
                  builder: (context, value, child) {
                    if (value == 0) {
                      return Container(
                        padding: const EdgeInsets.all(20.0),
                        width:
                            min(350, MediaQuery.of(context).size.width * 0.9),
                        height: 350,
                        child: LoginForm(
                          onLogin: (email, password) async {
                            if (await controller.login(
                                email, password, context)) {
                              context.go('/home');
                            }
                          },
                        ),
                      );
                    }
                    return const Placeholder();
                  })),
        ),
      ),
    );
  }
}
