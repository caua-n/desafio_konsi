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
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
            child: const SplashScreen(),
            key: state.pageKey,
            transitionsBuilder: slideFromRightTransition);
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
              transitionsBuilder: fadeTransition,
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
              transitionsBuilder: fadeTransition,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/revision',
      name: 'revision',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (BuildContext context, GoRouterState state) {
        final dto = state.extra as RevisionDto;
        return CustomTransitionPage(
          key: state.pageKey,
          child: RevisionScreen(
            revisionDto: dto,
          ),
          transitionsBuilder: slideFromRightTransition,
        );
      },
    ),
  ],
);

Widget fadeTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
}

Widget slideFromRightTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.easeInOut;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  var offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}
