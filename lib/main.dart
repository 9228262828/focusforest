import 'package:flutter/material.dart';
import 'app.dart';
import 'controllers/app_controller.dart';
import 'services/local_storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = LocalStorageService();
  await storage.init();

  final controller = AppController(storage);
  await controller.load();

  runApp(FocusForestApp(controller: controller));
}
