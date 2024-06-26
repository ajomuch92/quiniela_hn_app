import 'package:go_router/go_router.dart';
import 'package:quiniela_hn_app/database/index.dart';
import 'package:quiniela_hn_app/views/home.dart';
import 'package:quiniela_hn_app/views/login.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: '/login',
    builder: (context, state) => const Login(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => Home(),
  ),
], initialLocation: pb.authStore.isValid ? '/home' : '/login');
