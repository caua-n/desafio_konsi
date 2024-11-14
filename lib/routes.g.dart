// GENERATED FILE. PLEASE DO NOT EDIT THIS FILE!!

import 'package:routefly/routefly.dart';

import 'app/(public)/maps/maps_page.dart' as a1;
import 'app/(public)/saved/saved_page.dart' as a0;
import 'app/(public)/splash/splash_page.dart' as a2;

List<RouteEntity> get routes => [
      RouteEntity(
        key: '/saved',
        uri: Uri.parse('/saved'),
        routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
          ctx,
          settings,
          const a0.SavedPage(),
        ),
      ),
      RouteEntity(
        key: '/maps',
        uri: Uri.parse('/maps'),
        routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
          ctx,
          settings,
          const a1.MapsPage(),
        ),
      ),
      RouteEntity(
        key: '/splash',
        uri: Uri.parse('/splash'),
        routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
          ctx,
          settings,
          const a2.SplashPage(),
        ),
      ),
    ];

const routePaths = (
  path: '/',
  saved: '/saved',
  maps: '/maps',
  splash: '/splash',
);