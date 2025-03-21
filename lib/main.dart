import 'package:flutter/material.dart';

import 'app/core/di/app_modules.dart';
import 'app/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AppModules().setup();

  runApp(
    const MyApp(),
  );
}
