import 'package:desafio_konsi/app/core/controllers/controllers.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';

import 'package:desafio_konsi/app/features/locations/domain/usecases/search_locations_usecase.dart';
import 'package:desafio_konsi/app/screens/shell/maps/interactors/states/maps_state.dart';

class MapsControllerImpl extends BaseController<BaseState> {
  final SearchLocationsUsecase searchLocationsUsecase;

  MapsControllerImpl({required this.searchLocationsUsecase})
      : super(InitialState());

  void searchLocations(String cep) async {
    final result = await searchLocationsUsecase(cep);
    final newState = result.fold(
      (data) {
        return LoadedMapsState(listLocationsEntity: data);
      },
      ErrorState.new,
    );

    update(newState);
  }
}
