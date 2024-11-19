import 'package:desafio_konsi/app/app_widget.dart';
import 'package:desafio_konsi/app/core/services/get_it/service_locator.dart'
    as di;

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const AppWidget());
}
