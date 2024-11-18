import 'package:desafio_konsi/app/core/controllers/controllers.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';

import 'package:desafio_konsi/app/features/locations/domain/usecases/get_locations_usecase.dart';
import 'package:desafio_konsi/app/screens/shell/favorites/interactors/states/favorites_state.dart';

class FavortesControllerImpl extends BaseController<BaseState> {
  final GetLocationsUsecase getLocationsUsecase;

  FavortesControllerImpl({required this.getLocationsUsecase})
      : super(InitialState());

  void loadLocations() async {
    final result = await getLocationsUsecase();
    final newState = result.fold(
      (data) {
        return LoadedFavoritesState(listLocationsEntity: data);
      },
      ErrorState.new,
    );

    update(newState);
  }
}
