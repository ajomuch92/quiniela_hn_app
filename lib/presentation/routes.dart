import 'package:flutter/material.dart';
import 'package:quiniela_hn_app/presentation/views/Home/Home.dart';
import 'package:quiniela_hn_app/presentation/views/Index.dart';
import 'package:quiniela_hn_app/presentation/views/Splash.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/splash': (context) => const Splash(),
  '/': (context) =>  const Index(),
  '/home': (context) => const Home(),
};