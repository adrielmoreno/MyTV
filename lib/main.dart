import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app/core/di/app_modules.dart';
import 'app/data/services/local/secure_storage_service.dart';
import 'app/data/services/remote/moviedb_service.dart';
import 'app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  AppModules().setup();

  await inject.get<SecureStorageService>().init();
  await inject.get<MovieDBService>().init();

  runApp(
    const MyApp(),
  );
}
