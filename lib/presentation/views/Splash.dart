import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiniela_hn_app/data/repositories/LoginRepository.dart';
import 'package:quiniela_hn_app/domain/home/SettingsProvider.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  ConsumerState<Splash> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {

  @override
  void initState() {
    super.initState();
    loadPreference();
  }
  
  void loadPreference() async {
    bool isValidToken = await LoginRepository.isValidToken();
    String routePath = isValidToken ? '/home' : '/';
    if (isValidToken) {
      final settings = ref.read(settingProvider.notifier);
      await settings.loadSettings();
    }
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, routePath, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(child: SizedBox(height: 100, width: 100, child: Image.asset('assets/images/football-ball.png'))),
    );
  }
}