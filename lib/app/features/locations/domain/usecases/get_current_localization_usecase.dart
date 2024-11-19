import 'package:desafio_konsi/app/core/errors/default_exception.dart';
import 'package:desafio_konsi/app/core/services/localization/localization_service.dart';
import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:desafio_konsi/app/features/locations/data/adapters/coordinates_adapter.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/coordinates_entity.dart';
import 'package:result_dart/result_dart.dart';

class GetCurrentLocalizationUsecase {
  final LocalizationService localizationService;

  GetCurrentLocalizationUsecase(this.localizationService);

  Future<Output<CoordinatesEntity>> call() async {
    try {
      final position = await localizationService.getCurrentLocation();

      final data = {
        'id': null,
        'longitude': position.longitude,
        'latitude': position.latitude,
      };

      final coordinates = CoordinatesAdapter.fromJson(data);

      return Success(coordinates);
    } catch (error) {
      return Failure(DefaultException(message: error.toString()));
    }
  }
}
