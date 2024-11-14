import 'package:desafio_konsi/app/core/types/types.dart';
import 'package:result_dart/result_dart.dart';

abstract class ILocationsRepository {
  Future<Output<Unit>> addLocation();
}
