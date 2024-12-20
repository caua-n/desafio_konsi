import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:desafio_konsi/app/core/usecases/usecases.dart';

import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';
import 'package:desafio_konsi/app/features/locations/domain/repositories/i_locations_repository.dart';

abstract class ISearchPostalCodeUsecase
    extends UseCase<List<LocationEntity>, String> {}

class SearchPostalCodeUsecase extends ISearchPostalCodeUsecase {
  final ILocationsRepository repository;

  SearchPostalCodeUsecase({required this.repository});

  @override
  Future<Output<List<LocationEntity>>> call(String params) async {
    return await repository.searchPostalCode(params);
  }
}
