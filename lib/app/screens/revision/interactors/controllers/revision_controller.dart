import 'package:desafio_konsi/app/core/controllers/controllers.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/add_location_usecase.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/update_location_usecase.dart';
import 'package:flutter/material.dart';

class RevisionControllerImpl extends BaseController<BaseState> {
  final AddLocationUsecase addLocationUsecase;
  final UpdateLocationUsecase updateLocationUsecase;

  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController complementController = TextEditingController();

  RevisionControllerImpl({
    required this.addLocationUsecase,
    required this.updateLocationUsecase,
  }) : super(InitialState());

  void addLocation({
    required LocationEntity selectedLocation,
    required String number,
    required String complement,
    required void Function() onSuccess,
  }) async {
    final result = await addLocationUsecase(
      (
        selectedLocation: selectedLocation,
        number: number,
        complement: complement,
      ),
    );

    result.fold(
      (location) {
        onSuccess();
      },
      (error) {
        return ErrorState(error);
      },
    );
  }

  void updateLocation({
    required LocationEntity selectedLocation,
    required String number,
    required String complement,
    required void Function() onSuccess,
  }) async {
    final result = await updateLocationUsecase((
      selectedLocation: selectedLocation,
      number: number,
      complement: complement,
    ));

    result.fold(
      (location) {
        onSuccess();
      },
      (error) {
        return ErrorState(error);
      },
    );
  }
}
