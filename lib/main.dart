import 'package:draftea_pokedex/app/draftea_pokedex.dart';
import 'package:draftea_pokedex/core/config/app_config.dart';
import 'package:draftea_pokedex/core/storage/hive_client.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _bootstrap();
  runApp(const DrafteaPokedex());
}

Future<void> _bootstrap() async {
  debugPrint("Run enviroment ${AppConfig.environment}");
  await HiveClient.init();
  debugPrint("Hive client init succesful");
}
