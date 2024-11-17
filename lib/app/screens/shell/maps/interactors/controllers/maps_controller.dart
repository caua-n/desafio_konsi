import 'package:desafio_konsi/app/core/controllers/controllers.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';

import 'package:desafio_konsi/app/features/locations/domain/usecases/get_locations_usecase.dart';
import 'package:desafio_konsi/app/screens/shell/maps/interactors/states/maps_state.dart';

class MapsController extends BaseController<BaseState> {
  final GetLocationsUsecase getLocationsUsecase;

  MapsController({required this.getLocationsUsecase}) : super(InitialState());

  void loadLocations() async {
    final result = await getLocationsUsecase();
    final newState = result.fold(
      (data) {
        return LoadedLocationsState(listLocationsEntity: data);
      },
      ErrorState.new,
    );

    update(newState);
  }
}
