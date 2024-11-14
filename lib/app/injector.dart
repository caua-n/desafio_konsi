import 'package:auto_injector/auto_injector.dart';
import 'package:desafio_konsi/app/core/business_logic/locations_module/locations_module.dart';

final injector = AutoInjector(
  tag: 'AppModule',
  on: (i) {
    i.addInjector(locationsModule);
    i.commit();
  },
);
