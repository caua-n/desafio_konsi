import 'package:auto_injector/auto_injector.dart';
import 'package:desafio_konsi/app/(public)/home/locations/interactors/controllers/locations_controller.dart';
import 'package:desafio_konsi/app/modules/locations_module/locations_module.dart';

final injector = AutoInjector(
  tag: 'AppModule',
  on: (i) {
    i.addInjector(locationsModule);

    i.add<LocationsControllerImpl>(LocationsControllerImpl.new);

    i.commit();
  },
);
