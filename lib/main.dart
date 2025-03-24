import 'package:flutter/material.dart';

import 'app/core/di/app_modules.dart';
import 'app/data/services/local/secure_storage_service.dart';
import 'app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppModules().setup();

  await inject.get<SecureStorageService>().init();

  runApp(
    const MyApp(),
  );
}
