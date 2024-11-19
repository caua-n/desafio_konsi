import 'package:desafio_konsi/app/core/errors/default_exception.dart';
import 'package:desafio_konsi/app/core/services/localization/localization_service.dart';
import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:desafio_konsi/app/features/locations/data/adapters/coordinates_adapter.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/coordinates_entity.dart';
import 'package:desafio_konsi/app/features/locations/domain/repositories/i_localization_repository.dart';
import 'package:result_dart/result_dart.dart';

class LocalizationRepositoryImpl extends ILocalizationRepository {
  final LocalizationService localizationService;

  LocalizationRepositoryImpl(this.localizationService);

  @override
  Future<Output<CoordinatesEntity>> getCurrentLocalization() async {
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
