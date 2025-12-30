import 'package:draftea_pokedex/core/ui/media_query_ext.dart';
import 'package:draftea_pokedex/feature/pokemon/presentation/cubit/pokemon_detail_cubit.dart';
import 'package:draftea_pokedex/feature/pokemon/presentation/cubit/pokemon_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonDetailPage extends StatelessWidget {
  final int pokemonId;

  const PokemonDetailPage({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    final isWide = context.isTabletUp;

    return BlocProvider(
      create: (_) => PokemonDetailCubit(context.read())..load(pokemonId),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
          builder: (context, state) {
            if (state is PokemonDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PokemonDetailError) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is PokemonDetailLoaded) {
              final pokemon = state.pokemon;
              final pokemonImage = Image.network(pokemon.imageUrl, height: 200);
              final pokemonInfo = Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text('#${pokemon.id}'),
                ],
              );
              if (!isWide) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      pokemonImage,
                      const SizedBox(height: 24),
                      pokemonInfo,
                    ],
                  ),
                );
              }
              return Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    pokemonImage,
                    const SizedBox(width: 32),
                    pokemonInfo,
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
