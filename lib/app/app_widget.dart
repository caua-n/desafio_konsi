import 'package:desafio_konsi/routes.g.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routefly.routerConfig(
        routes: routes,
      ),
    );
  }
}
