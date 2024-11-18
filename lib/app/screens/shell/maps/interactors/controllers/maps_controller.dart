import 'package:desafio_konsi/app/core/controllers/controllers.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/get_initial_localization_usecase.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/search_locations_usecase.dart';
import 'package:desafio_konsi/app/screens/shell/maps/interactors/states/maps_state.dart';

class MapsControllerImpl extends BaseController<BaseState> {
  final SearchLocationsUsecase searchLocationsUsecase;
  final GetInitialLocalizationUsecase getCurrentLocalizationUsecase;

  MapsControllerImpl({
    required this.searchLocationsUsecase,
    required this.getCurrentLocalizationUsecase,
  }) : super(InitialState());

  void initializer() async {
    update(LoadingState());

    final result = await getCurrentLocalizationUsecase();
    final newState = result.fold(
      (coordinates) {
        return LoadedMapsState(initialCoordinatesEntity: coordinates);
      },
      ErrorState.new,
    );

    update(newState);
  }

  void searchLocations(String cep) async {
    update(LoadingState());

    final result = await searchLocationsUsecase(cep);
    final newState = result.fold(
      (data) {
        return SearchResultState(listLocationsEntity: data);
      },
      ErrorState.new,
    );

    update(newState);
  }
}
