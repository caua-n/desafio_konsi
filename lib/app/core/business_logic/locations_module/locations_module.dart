import 'package:auto_injector/auto_injector.dart';

final locationsModule = AutoInjector(
  tag: 'locationsModule',
  on: (i) {
    i.addInstance(1);
  },
);
