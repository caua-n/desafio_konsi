import 'package:desafio_konsi/app/routes.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Desafio Konsi',
      routerConfig: router,
    );
  }
}
