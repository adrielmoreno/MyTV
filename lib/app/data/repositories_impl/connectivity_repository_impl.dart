import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../domain/repositories/connectivity_repository.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  @override
  Future<bool> get hasIntenert async =>
      await InternetConnection().hasInternetAccess;
}
