import 'package:draftea_pokedex/core/ui/media_query_ext.dart';
import 'package:draftea_pokedex/feature/pokemon/presentation/cubit/pokemon_list_cubit.dart';
import 'package:draftea_pokedex/feature/pokemon/presentation/cubit/pokemon_list_states.dart';
import 'package:draftea_pokedex/feature/pokemon/presentation/widgets/pokemon_card.dart';
import 'package:draftea_pokedex/core/ui/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = context.isTabletUp;

    return BlocProvider(
      create: (_) => PokemonListCubit(context.read())..loadInitial(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pokédex',
            style: UiTypography.titleLarge,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: UiColors.primary,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<PokemonListCubit, PokemonListState>(
          builder: (context, state) {
            if (state is PokemonListLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PokemonListError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PokemonListCubit>().loadInitial();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UiColors.primary,
                      ),
                      child: const Text(
                        'Retry',
                        style: UiTypography.chipLabel,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is PokemonListLoaded) {
              if (state.items.isEmpty) {
                return const Center(
                  child: Text(
                    'No Pokémon available.\nConnect to the internet to load data.',
                    textAlign: TextAlign.center,
                  ),
                );
              }
              final pokemonList = NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels > notification.metrics.maxScrollExtent - 200 && state.hasMore) {
                    context.read<PokemonListCubit>().loadMore();
                  }
                  return false;
                },
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  itemCount: state.items.length,
                  itemBuilder: (_, index) => PokemonCard(pokemon: state.items[index]),
                ),
              );
              return isWide
                  ? Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: pokemonList,
                      ),
                    )
                  : pokemonList;
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
