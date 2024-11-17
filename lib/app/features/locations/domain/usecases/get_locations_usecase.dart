import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:desafio_konsi/app/core/usecases/usecases.dart';

import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';
import 'package:desafio_konsi/app/features/locations/domain/repositories/i_locations_repository.dart';

abstract class IGetLocationsUsecase
    extends UseCase<List<LocationEntity>, Object?> {}

class GetLocationsUsecase extends IGetLocationsUsecase {
  final ILocationsRepository repository;

  GetLocationsUsecase({required this.repository});

  @override
  Future<Output<List<LocationEntity>>> call([params]) async {
    return await repository.getSavedLocations();
  }
}
