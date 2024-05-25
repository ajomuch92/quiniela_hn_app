import 'package:go_router/go_router.dart';
import 'package:quiniela_hn_app/views/login.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: '/login',
    builder: (context, state) => const Login(),
  ),
], initialLocation: '/login');
