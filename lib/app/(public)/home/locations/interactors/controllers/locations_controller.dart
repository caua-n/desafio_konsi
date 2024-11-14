import 'package:desafio_konsi/app/(public)/home/locations/interactors/states/locations_state.dart';
import 'package:desafio_konsi/app/modules/locations_module/domain/usecases/get_locations_usecase.dart';
import 'package:desafio_konsi/app/core/controllers/controllers.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:result_dart/result_dart.dart';

class LocationsControllerImpl extends BaseController {
  final IGetLocationsUsecase getLocationsUsecase;

  LocationsControllerImpl({
    required this.getLocationsUsecase,
  }) : super(InitialState());

  void initialize() async {
    final result = await getLocationsUsecase(unit);

    if (result.isError()) update(ErrorState(result.exceptionOrNull()!));

    final newState = result.fold((data) {
      return LoadedLocationsState(
        listLocations: data,
      );
    }, ErrorState.new);

    update(newState);
  }
}
