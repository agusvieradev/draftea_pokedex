import 'package:draftea_pokedex/app/app_dependencies.dart';
import 'package:draftea_pokedex/app/router.dart';
import 'package:draftea_pokedex/feature/pokemon/domain/pokemon_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrafteaPokedex extends StatelessWidget {
  const DrafteaPokedex({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<PokemonRepository>.value(
      value: pokemonRepository,
      child: MaterialApp.router(
        title: 'Pokedex',
        routerConfig: pokedexRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
