import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../feature/home/pages/home_screen.dart';
import '../feature/presence/pages/presence_screen.dart';

part 'app_router.g.dart';

/// Home route
@TypedGoRoute<HomeRoute>(
  path: '/',
  name: 'home',
  routes: [TypedGoRoute<PresenceRoute>(path: '/presence', name: 'presence')],
)
class HomeRoute extends GoRouteData with _$HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

/// Presence route
class PresenceRoute extends GoRouteData with _$PresenceRoute {
  const PresenceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PresenceScreen();
}

GoRouter get appRouter => GoRouter(initialLocation: '/', routes: $appRoutes);
