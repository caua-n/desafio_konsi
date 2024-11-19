import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:desafio_konsi/app/core/usecases/usecases.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/coordinates_entity.dart';
import 'package:desafio_konsi/app/features/locations/domain/repositories/i_localization_repository.dart';

abstract class IGetCurrentLocalizationUsecase
    extends UseCase<List<CoordinatesEntity>, Object?> {}

class GetCurrentLocalizationUsecase {
  final ILocalizationRepository repository;
  GetCurrentLocalizationUsecase({required this.repository});

  Future<Output<CoordinatesEntity>> call() async {
    return await repository.getCurrentLocalization();
  }
}
