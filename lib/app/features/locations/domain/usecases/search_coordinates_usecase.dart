import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:desafio_konsi/app/core/usecases/usecases.dart';

import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';
import 'package:desafio_konsi/app/features/locations/domain/models/coordinates_model.dart';
import 'package:desafio_konsi/app/features/locations/domain/repositories/i_locations_repository.dart';

abstract class ISearchCoordinatesUsecase
    extends UseCase<LocationEntity, CoordinatesModel> {}

class SearchCoordinatesUsecase extends ISearchCoordinatesUsecase {
  final ILocationsRepository repository;

  SearchCoordinatesUsecase({required this.repository});

  @override
  Future<Output<LocationEntity>> call(CoordinatesModel params) async {
    return await repository.searchCoordinates(
        params.latitude, params.longitude);
  }
}
