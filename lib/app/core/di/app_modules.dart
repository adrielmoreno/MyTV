import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../data/repositories_impl/account_repository_impl.dart';
import '../../data/repositories_impl/auth_repository_impl.dart';
import '../../data/repositories_impl/connectivity_repository_impl.dart';
import '../../data/services/local/secure_storage_service.dart';
import '../../data/services/remote/moviedb_service.dart';
import '../../domain/repositories/account_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/connectivity_repository.dart';

final inject = GetIt.instance;

class AppModules {
  setup() {
    _setupCoreModule();
    _setupConnectivityModule();
    _setupAuthModule();
    _setupAccountModule();
  }

  _setupCoreModule() {
    inject.registerLazySingleton(() => InternetConnection());
    inject.registerLazySingleton(() => SecureStorageService());
    inject.registerLazySingleton(() => MovieDBService());
  }

  _setupAuthModule() {
    inject.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(inject.get(), inject.get()));
  }

  _setupAccountModule() {
    inject.registerLazySingleton<AccountRepository>(
        () => AccountRepositoryImpl(inject.get(), inject.get()));
  }

  _setupConnectivityModule() {
    inject.registerLazySingleton<ConnectivityRepository>(
        () => ConnectivityRepositoryImpl(inject.get()));
  }
}
