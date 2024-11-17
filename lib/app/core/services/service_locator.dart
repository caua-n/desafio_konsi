import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:desafio_konsi/app/core/services/database/database_helper.dart';
import 'package:desafio_konsi/app/core/utils/network_info.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/local/locations_local_datasource.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/locations_datasource.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/remote/locations_remote_datasource.dart';
import 'package:desafio_konsi/app/features/locations/data/datasources/fallback_locations_datasource.dart';
import 'package:desafio_konsi/app/features/locations/data/repositories/locations_repository_impl.dart';
import 'package:desafio_konsi/app/features/locations/domain/repositories/i_locations_repository.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/add_location_usecase.dart';
import 'package:desafio_konsi/app/features/locations/domain/usecases/get_locations_usecase.dart';
import 'package:desafio_konsi/app/screens/shell/maps/interactors/controllers/maps_controller.dart';
import 'package:desafio_konsi/app/screens/shell/locations/interactors/controllers/locations_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // **Dio**
  sl.registerLazySingleton(() => Dio());

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

  sl.registerLazySingleton<LocationsDatasource>(
      () => FallbackLocationsDatasource(
            remoteDatasource: sl<RemoteLocationsDatasource>(),
            localDatasource: sl<LocalLocationsDatasource>(),
          ));

  // **Repositories**
  sl.registerLazySingleton<ILocationsRepository>(
      () => LocationsRepositoryImpl(sl<LocationsDatasource>()));

  // **Use Cases**
  sl.registerLazySingleton(
      () => GetLocationsUsecase(repository: sl<ILocationsRepository>()));
  sl.registerLazySingleton(
      () => AddLocationUsecase(repository: sl<ILocationsRepository>()));

  // **Controllers**
  sl.registerFactory(() => MapsController(
        getLocationsUsecase: sl<GetLocationsUsecase>(),
      ));

  sl.registerFactory(() => LocationsController(
        getLocationsUsecase: sl<GetLocationsUsecase>(),
      ));
}
