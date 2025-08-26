import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../feature/home/pages/home_screen.dart';

part 'app_router.g.dart';

@TypedGoRoute<HomeRoute>(path: '/', name: 'home')
class HomeRoute extends GoRouteData with _$HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

class AppRouter {
  static final GoRouter router = GoRouter(initialLocation: '/', routes: $appRoutes);
}
