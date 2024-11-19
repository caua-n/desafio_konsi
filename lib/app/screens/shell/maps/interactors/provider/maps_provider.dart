import 'package:desafio_konsi/app/screens/shell/maps/interactors/controllers/maps_controller.dart';
import 'package:flutter/widgets.dart';

enum MapsEnum {
  controller
} //para informar qual controller notificar se tiver multiplos controllers

class MapsProvider extends InheritedModel<MapsEnum> {
  final MapsControllerImpl controller;

  const MapsProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  @override
  bool updateShouldNotify(MapsProvider old) {
    return controller != old.controller;
  }

  @override
  bool updateShouldNotifyDependent(MapsProvider old, Set<MapsEnum> aspects) {
    return (aspects.contains(MapsEnum.controller) &&
        old.controller != controller);
  }

  static MapsControllerImpl? ofMaps(BuildContext context) {
    return InheritedModel.inheritFrom<MapsProvider>(context,
            aspect: MapsEnum.controller)
        ?.controller;
  }
}
