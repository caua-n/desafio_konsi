import 'package:desafio_konsi/app/core/controllers/controllers.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/features/locations/domain/entities/location_entity.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/add_location_usecase.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RevisionControllerImpl extends BaseController<BaseState>
    with ChangeNotifier {
  final AddLocationUsecase addLocationUsecase;

  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController complementController = TextEditingController();

  RevisionControllerImpl({
    required this.addLocationUsecase,
  }) : super(InitialState());

  void addLocation(
    BuildContext context, {
    required LocationEntity selectedLocation,
    required String number,
    required String complement,
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
        context.go('/favorites');
      },
      (error) {
        return ErrorState(error);
      },
    );

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
