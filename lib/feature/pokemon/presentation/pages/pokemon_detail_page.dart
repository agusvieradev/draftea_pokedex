import 'package:draftea_pokedex/feature/pokemon/presentation/cubit/pokemon_detail_cubit.dart';
import 'package:draftea_pokedex/feature/pokemon/presentation/cubit/pokemon_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonDetailPage extends StatelessWidget {
  final int pokemonId;

  const PokemonDetailPage({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
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
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(pokemon.imageUrl, height: 200),
                    const SizedBox(height: 16),
                    Text(
                      pokemon.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text('#${pokemon.id}'),
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
