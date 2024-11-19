import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:desafio_konsi/app/core/usecases/usecases.dart';
import 'package:desafio_konsi/app/features/locations/domain/repositories/i_locations_repository.dart';

abstract class IDeleteLocationUsecase extends UseCase<bool, int> {}

class DeleteLocationUsecase extends IDeleteLocationUsecase {
  final ILocationsRepository repository;

  DeleteLocationUsecase({required this.repository});

  @override
  Future<Output<bool>> call(int params) async {
    return await repository.deleteLocation(params);
  }
}
