import 'package:connectivity_plus/connectivity_plus.dart';
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
import 'package:get_it/get_it.dart';
import 'package:uno/uno.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Injeção do Uno (Cliente HTTP)
  sl.registerLazySingleton(() => Uno());

  // internet
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<Connectivity>()));

  // datasources
  sl.registerLazySingleton<LocalLocationsDatasource>(
      () => LocalLocationsDatasource());
  sl.registerLazySingleton<RemoteLocationsDatasource>(
      () => RemoteLocationsDatasource(sl<Uno>()));
  sl.registerLazySingleton<LocationsDatasource>(
      () => FallbackLocationsDatasource(
            localDatasource: sl<LocalLocationsDatasource>(),
            remoteDatasource: sl<RemoteLocationsDatasource>(),
          ));

  // repo
  sl.registerLazySingleton<ILocationsRepository>(
    () => LocationsRepositoryImpl(sl<LocationsDatasource>()),
  );

  // usercases
  sl.registerLazySingleton(
      () => GetLocationsUsecase(repository: sl<ILocationsRepository>()));
  sl.registerLazySingleton(
      () => AddLocationUsecase(repository: sl<ILocationsRepository>()));

  // controllers
  sl.registerFactory(() => MapsController(
        getLocationsUsecase: sl<GetLocationsUsecase>(),
      ));
}
