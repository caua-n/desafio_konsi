import 'package:desafio_konsi/app/core/services/localization/localization_service.dart';
import 'package:desafio_konsi/app/features/locations/data/repositories/localization_repository_impl.dart';
import 'package:desafio_konsi/app/features/locations/domain/repositories/i_localization_repository.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/delete_location_usecase.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/get_current_localization_usecase.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/search_coordinates_usecase.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/search_postal_code_usecase.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/update_location_usecase.dart';
import 'package:desafio_konsi/app/screens/revision/interactors/controllers/revision_controller.dart';
import 'package:desafio_konsi/app/screens/shell/favorites/interactors/controllers/favorites_controller.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:desafio_konsi/app/core/services/database/database_helper.dart';
import 'package:desafio_konsi/app/core/utils/network_info.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/local/locations_local_datasource.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/i_locations_datasource.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/remote/locations_remote_datasource.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/locations_datasource_impl.dart';
import 'package:desafio_konsi/app/features/locations/data/repositories/locations_repository_impl.dart';
import 'package:desafio_konsi/app/features/locations/domain/repositories/i_locations_repository.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/add_location_usecase.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/get_locations_usecase.dart';
import 'package:desafio_konsi/app/screens/shell/maps/interactors/controllers/maps_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // **Dio**
  sl.registerLazySingleton(() => Dio());

  // **Localization**
  sl.registerLazySingleton(() => LocalizationService());

  // **Internet**
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<Connectivity>()));

  // **Database**
  sl.registerLazySingleton<Future<Database>>(
      () => DatabaseHelper.initDatabase());

  // **Datasources**
  sl.registerLazySingleton<RemoteLocationsDatasource>(
      () => RemoteLocationsDatasource(sl<Dio>()));

  sl.registerLazySingleton<LocalLocationsDatasource>(
      () => LocalLocationsDatasource(sl<Future<Database>>()));

  sl.registerLazySingleton<ILocationsDatasource>(() => LocationsDatasourceImpl(
        remoteDatasource: sl<RemoteLocationsDatasource>(),
        localDatasource: sl<LocalLocationsDatasource>(),
      ));

  // **Repositories**
  sl.registerLazySingleton<ILocationsRepository>(
      () => LocationsRepositoryImpl(sl<ILocationsDatasource>()));
  sl.registerLazySingleton<ILocalizationRepository>(
      () => LocalizationRepositoryImpl(sl<LocalizationService>()));

  // **Use Cases**
  sl.registerLazySingleton(
      () => GetLocationsUsecase(repository: sl<ILocationsRepository>()));
  sl.registerLazySingleton(
      () => AddLocationUsecase(repository: sl<ILocationsRepository>()));
  sl.registerLazySingleton(
      () => UpdateLocationUsecase(repository: sl<ILocationsRepository>()));
  sl.registerLazySingleton(
      () => DeleteLocationUsecase(repository: sl<ILocationsRepository>()));
  sl.registerLazySingleton(
      () => SearchPostalCodeUsecase(repository: sl<ILocationsRepository>()));
  sl.registerLazySingleton(
      () => SearchCoordinatesUsecase(repository: sl<ILocationsRepository>()));

  sl.registerLazySingleton(() =>
      GetCurrentLocalizationUsecase(repository: sl<ILocalizationRepository>()));

  // **Controllers**
  sl.registerFactory(() => MapsControllerImpl(
        searchPostalCodeUsecase: sl<SearchPostalCodeUsecase>(),
        searchCoordinatesUsecase: sl<SearchCoordinatesUsecase>(),
        getCurrentLocalizationUsecase: sl<GetCurrentLocalizationUsecase>(),
      ));

  sl.registerFactory(() => FavoritesControllerImpl(
        getLocationsUsecase: sl<GetLocationsUsecase>(),
        deleteLocationUsecase: sl<DeleteLocationUsecase>(),
      ));

  sl.registerFactory(() => RevisionControllerImpl(
      addLocationUsecase: sl<AddLocationUsecase>(),
      updateLocationUsecase: sl<UpdateLocationUsecase>()));
}
