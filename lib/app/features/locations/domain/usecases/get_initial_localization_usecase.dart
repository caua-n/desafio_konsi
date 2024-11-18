import 'package:desafio_konsi/app/core/errors/default_exception.dart';
import 'package:desafio_konsi/app/core/services/localization/localization_service.dart';
import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:desafio_konsi/app/features/locations/data/adapters/initial_coordinates_adapter.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/initial_coordinates_entity.dart';
import 'package:result_dart/result_dart.dart';

class GetInitialLocalizationUsecase {
  final LocalizationService localizationService;

  GetInitialLocalizationUsecase(this.localizationService);

  Future<Output<InitialCoordinatesEntity>> call() async {
    try {
      final position = await localizationService.getCurrentLocation();

      final data = {
        'id': null,
        'longitude': position.longitude,
        'latitude': position.latitude,
      };

      final coordinates = InitialCoordinatesAdapter.fromJson(data);

      return Success(coordinates);
    } catch (e) {
      return const Failure(DefaultException(message: 'Erro desconhecido'));
    }
  }
}
