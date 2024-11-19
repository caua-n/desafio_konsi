import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/coordinates_entity.dart';

abstract class ILocalizationRepository {
  Future<Output<CoordinatesEntity>> getCurrentLocalization();
}
