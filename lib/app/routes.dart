import 'package:desafio_konsi/app/screens/revision/interactors/dtos/revision_dto.dart';
import 'package:desafio_konsi/app/screens/revision/revision_screen.dart';
import 'package:desafio_konsi/app/screens/shell/favorites/favorites_screen.dart';
import 'package:desafio_konsi/app/screens/shell/maps/maps_screen.dart';
import 'package:desafio_konsi/app/screens/shell/widgets/shell_bar.dart';
import 'package:desafio_konsi/app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Navigator keys for root and shell navigators
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

// Main router configuration
final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey, // Root Navigator
  routes: <RouteBase>[
    // Splash screen route
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    // Shell route for bottom navigation bar
    ShellRoute(
      navigatorKey: _shellNavigatorKey, // Shell Navigator
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return ScaffoldWithNavBar(child: child); // Shell with child widget
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/maps',
          parentNavigatorKey: _shellNavigatorKey, // Route inside Shell
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
          parentNavigatorKey: _shellNavigatorKey, // Route inside Shell
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
    // Revision route outside the shell
    GoRoute(
      path: '/revision',
      name: 'revision', // Name for pushNamed
      parentNavigatorKey: _rootNavigatorKey, // Use root Navigator
      builder: (BuildContext context, GoRouterState state) {
        // Retrieve the RevisionDto from extra
        final dto = state.extra as RevisionDto;
        return RevisionScreen(
          revisionDto: dto,
        );
      },
    ),
  ],
);
