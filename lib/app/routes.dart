import 'package:desafio_konsi/app/screens/shell/favorites/favorites_screen.dart';
import 'package:desafio_konsi/app/screens/shell/maps/maps_screen.dart';
import 'package:desafio_konsi/app/screens/shell/widgets/app_bar.dart';
import 'package:desafio_konsi/app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/maps',
          builder: (BuildContext context, GoRouterState state) {
            return const MapsScreen();
          },
        ),
        GoRoute(
          path: '/favorites',
          builder: (BuildContext context, GoRouterState state) {
            return const FavoritesScreen();
          },
        ),
      ],
    ),
  ],
);
