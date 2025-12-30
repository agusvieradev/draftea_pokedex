import 'dart:developer' as dev;
import 'package:draftea_pokedex/app/draftea_pokedex.dart';
import 'package:draftea_pokedex/core/config/app_config.dart';
import 'package:draftea_pokedex/core/observer/bloc_observer.dart';
import 'package:draftea_pokedex/core/storage/hive_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setupObservers();
  await _initCore();
  runApp(const DrafteaPokedex());
}

Future<void> _initCore() async {
  dev.log(
    'Starting app',
    name: 'Init Core',
    error: AppConfig.environment,
  );
  await HiveClient.init();
}

void _setupObservers() {
  Bloc.observer = AppBlocObserver();

  FlutterError.onError = (details) {
    dev.log(
      'Flutter error',
      error: details.exception,
      stackTrace: details.stack,
      name: 'Flutter',
    );
  };
}
