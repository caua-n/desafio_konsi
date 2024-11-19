import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsState extends BaseState {
  final Map<MarkerId, Marker> markers;

  MapsState({required this.markers});
}

class SearchResultState extends MapsState {
  final List<LocationEntity> listLocationsEntity;

  SearchResultState({
    required super.markers,
    required this.listLocationsEntity,
  });
}

class LocalizationDeniedState extends BaseState {
  final String reason;

  LocalizationDeniedState({
    required this.reason,
  });
}
