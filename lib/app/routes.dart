import 'package:desafio_konsi/app/screens/revision/interactors/dtos/revision_dto.dart';
import 'package:desafio_konsi/app/screens/revision/revision_screen.dart';
import 'package:desafio_konsi/app/screens/shell/favorites/favorites_screen.dart';
import 'package:desafio_konsi/app/screens/shell/maps/maps_screen.dart';
import 'package:desafio_konsi/app/screens/shell/widgets/shell_bar.dart';
import 'package:desafio_konsi/app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
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
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const MapsScreen(),
              key: state.pageKey,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity:
                      CurveTween(curve: Curves.bounceIn).animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          path: '/favorites',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const FavoritesScreen(),
              key: state.pageKey,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity:
                      CurveTween(curve: Curves.bounceIn).animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/revision',
      name: 'revision',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        final dto = state.extra as RevisionDto;
        return RevisionScreen(
          revisionDto: dto,
        );
      },
    ),
  ],
);
