import 'package:desafio_konsi/app/core/business_logic/locations_module/domain/entities/list_locations_entity.dart';
import 'package:desafio_konsi/app/core/business_logic/locations_module/domain/repositories/i_locations_repository.dart';
import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:desafio_konsi/app/core/usecases/usecases.dart';

abstract class IGetLocationsUsecase
    extends UseCase<ListLocationsEntity, Object?> {}

class GetLocationsUsecase extends IGetLocationsUsecase {
  final ILocationsRepository repository;

  GetLocationsUsecase({required this.repository});

  @override
  Future<Output<ListLocationsEntity>> call([params]) async {
    return await repository.getLocations();
  }
}
