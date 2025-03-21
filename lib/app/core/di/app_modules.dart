import 'package:get_it/get_it.dart';

import '../../data/repositories_impl/auth_repository_impl.dart';
import '../../data/repositories_impl/connectivity_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/connectivity_repository.dart';

final inject = GetIt.instance;

class AppModules {
  setup() {
    _setupAuthModule();
    _setupConnectivityModule();
  }

  _setupAuthModule() {
    inject.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  }

  _setupConnectivityModule() {
    inject.registerLazySingleton<ConnectivityRepository>(
        () => ConnectivityRepositoryImpl());
  }
}
