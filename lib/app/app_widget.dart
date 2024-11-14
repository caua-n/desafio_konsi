import 'package:desafio_konsi/routes.g.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Desafio Konsi',
      routerConfig: Routefly.routerConfig(
        initialPath: routePaths.splash,
        routes: routes,
      ),
    );
  }
}
