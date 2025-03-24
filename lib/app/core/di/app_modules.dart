import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../data/repositories_impl/auth_repository_impl.dart';
import '../../data/repositories_impl/connectivity_repository_impl.dart';

final inject = GetIt.instance;

class AppModules {
  setup() {
    _setupAuthModule();
    _setupConnectivityModule();
  }

  _setupAuthModule() {
    inject.registerLazySingleton(() => AuthRepositoryImpl());
  }

  _setupConnectivityModule() {
    inject.registerLazySingleton(() => InternetConnection());
    inject
        .registerLazySingleton(() => ConnectivityRepositoryImpl(inject.get()));
  }
}
