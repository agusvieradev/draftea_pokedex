import 'dart:developer' as dev;
import 'package:draftea_pokedex/core/config/app_config.dart';
import 'package:draftea_pokedex/core/network/dio_client.dart';
import 'package:draftea_pokedex/core/observer/bloc_observer.dart';
import 'package:draftea_pokedex/core/storage/hive_client.dart';
import 'package:draftea_pokedex/feature/pokemon/data/pokemon_api.dart';
import 'package:draftea_pokedex/feature/pokemon/data/pokemon_local.dart';
import 'package:draftea_pokedex/feature/pokemon/data/pokemon_repository_impl.dart';
import 'package:draftea_pokedex/feature/pokemon/domain/pokemon_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

late final PokemonRepository pokemonRepository;

Future<void> initCore() async {
  dev.log(
    'Starting app',
    name: 'Init Core. Environment: ${AppConfig.environment}',
  );
  await HiveClient.init();
  await Hive.openBox('pokemon');
  final dio = DioClient.create(
    baseUrl: AppConfig.apiBaseUrl,
    connectTimeout: const Duration(seconds: AppConfig.connectionTimeout),
    receiveTimeout: const Duration(seconds: AppConfig.receiveTimeout),
  );
  final pokemonApi = PokemonApi(dio);
  final pokemonLocalStorage = PokemonLocal(Hive.box('pokemon'));
  pokemonRepository = PokemonRepositoryImpl(
    api: pokemonApi,
    local: pokemonLocalStorage,
  );
}

void setupObservers() {
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
