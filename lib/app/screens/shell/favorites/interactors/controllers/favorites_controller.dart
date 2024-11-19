import 'package:desafio_konsi/app/core/controllers/controllers.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';

import 'package:desafio_konsi/app/features/locations/domain/usecases/get_locations_usecase.dart';
import 'package:desafio_konsi/app/screens/shell/favorites/interactors/states/favorites_state.dart';
import 'package:flutter/material.dart';

class FavoritesControllerImpl extends BaseController<BaseState> {
  final GetLocationsUsecase getLocationsUsecase;

  FavoritesControllerImpl({required this.getLocationsUsecase})
      : super(InitialState());

  final TextEditingController searchInput = TextEditingController();
  List<LocationEntity> originalList = [];
  List<LocationEntity> filteredList = [];

  void loadLocations() async {
    final result = await getLocationsUsecase();
    final newState = result.fold(
      (data) {
        originalList = data;
        filteredList = List.from(originalList);
        return LoadedFavoritesState(listLocationsEntity: data);
      },
      ErrorState.new,
    );

    update(newState);
  }

  void filterLocations(String query) {
    if (query.isEmpty) {
      filteredList = List.from(originalList);
    } else {
      filteredList = originalList
          .where((location) => location.postalCode.contains(query))
          .toList();
    }
    update(LoadedFavoritesState(listLocationsEntity: filteredList));
  }
}
