import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:desafio_konsi/app/core/usecases/usecases.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';
import 'package:desafio_konsi/app/features/locations/domain/repositories/i_locations_repository.dart';

abstract class IAddLocationUsecase extends UseCase<LocationEntity, Object?> {}

class AddLocationUsecase extends IAddLocationUsecase {
  final ILocationsRepository repository;

  AddLocationUsecase({required this.repository});

  @override
  Future<Output<LocationEntity>> call([params]) {
    return repository.addLocation();
  }
}
