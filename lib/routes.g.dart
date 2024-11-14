// GENERATED FILE. PLEASE DO NOT EDIT THIS FILE!!

import 'package:routefly/routefly.dart';

import 'app/(public)/edit/edit_page.dart' as a0;
import 'app/(public)/locations/locations_page.dart' as a1;
import 'app/(public)/maps/maps_page.dart' as a2;
import 'app/(public)/splash/splash_page.dart' as a3;

List<RouteEntity> get routes => [
      RouteEntity(
        key: '/edit',
        uri: Uri.parse('/edit'),
        routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
          ctx,
          settings,
          const a0.EditPage(),
        ),
      ),
      RouteEntity(
        key: '/locations',
        uri: Uri.parse('/locations'),
        routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
          ctx,
          settings,
          const a1.LocationsPage(),
        ),
      ),
      RouteEntity(
        key: '/maps',
        uri: Uri.parse('/maps'),
        routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
          ctx,
          settings,
          const a2.MapsPage(),
        ),
      ),
      RouteEntity(
        key: '/splash',
        uri: Uri.parse('/splash'),
        routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
          ctx,
          settings,
          const a3.SplashPage(),
        ),
      ),
    ];

const routePaths = (
  path: '/',
  edit: '/edit',
  locations: '/locations',
  maps: '/maps',
  splash: '/splash',
);
