import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../data/repositories_impl/auth_repository_impl.dart';
import '../../data/repositories_impl/connectivity_repository_impl.dart';
import '../../data/services/local/secure_storage_service.dart';

final inject = GetIt.instance;

class AppModules {
  setup() {
    _setupAuthModule();
    _setupConnectivityModule();
    _setupCoreModule();
  }

  _setupCoreModule() {
    inject.registerLazySingleton(() => InternetConnection());
    inject.registerLazySingleton(() => SecureStorageService());
  }

  _setupAuthModule() {
    inject.registerLazySingleton(() => AuthRepositoryImpl(inject.get()));
  }

  _setupConnectivityModule() {
    inject
        .registerLazySingleton(() => ConnectivityRepositoryImpl(inject.get()));
  }
}
