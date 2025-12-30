import 'package:draftea_pokedex/core/ui/media_query_ext.dart';
import 'package:draftea_pokedex/feature/pokemon/presentation/cubit/pokemon_detail_cubit.dart';
import 'package:draftea_pokedex/feature/pokemon/presentation/cubit/pokemon_detail_state.dart';
import 'package:draftea_pokedex/core/ui/ui_constants.dart';
import 'package:draftea_pokedex/feature/pokemon/presentation/widgets/pokemon_header_section.dart';
import 'package:draftea_pokedex/feature/pokemon/presentation/widgets/pokemon_image_section.dart';
import 'package:draftea_pokedex/feature/pokemon/presentation/widgets/stats_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PokemonDetailPage extends StatelessWidget {
  final int pokemonId;

  const PokemonDetailPage({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    final isWide = context.isTabletUp;

    return BlocProvider(
      create: (_) => PokemonDetailCubit(context.read())..load(pokemonId),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: const Icon(Icons.arrow_back),
          ),
          backgroundColor: UiColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
          builder: (context, state) {
            if (state is PokemonDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PokemonDetailError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PokemonDetailCubit>().load(pokemonId);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UiColors.primary,
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (state is PokemonDetailLoaded) {
              final pokemon = state.pokemon;
              final content = SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PokemonImageSection(imageUrl: pokemon.imageUrl),
                      const SizedBox(height: UiConstants.defaultSpacing),
                      PokemonHeaderSection(
                        name: pokemon.name,
                        id: pokemon.id,
                        types: pokemon.types!,
                      ),
                      const SizedBox(height: 28),
                      StatsSection(
                        title: 'Physical Stats',
                        stats: {
                          'height': pokemon.height!,
                          'weight': pokemon.weight!,
                        },
                        isPhysical: true,
                      ),
                      const SizedBox(height: 24),
                      StatsSection(
                        title: 'Battle Stats',
                        stats: pokemon.stats!,
                        isPhysical: false,
                      ),
                    ],
                  ),
                ),
              );
              return isWide
                  ? Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: content,
                      ),
                    )
                  : content;
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
