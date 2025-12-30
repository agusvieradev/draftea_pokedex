import 'package:draftea_pokedex/core/ui/media_query_ext.dart';
import 'package:draftea_pokedex/feature/pokemon/presentation/cubit/pokemon_list_cubit.dart';
import 'package:draftea_pokedex/feature/pokemon/presentation/cubit/pokemon_list_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = context.isTabletUp;

    return BlocProvider(
      create: (_) => PokemonListCubit(context.read())..loadInitial(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pokédex'),
        ),
        body: BlocBuilder<PokemonListCubit, PokemonListState>(
          builder: (context, state) {
            if (state is PokemonListLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PokemonListError) {
              return Center(child: Text(state.message));
            }
            if (state is PokemonListLoaded) {
              final pokemonList = NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels > notification.metrics.maxScrollExtent - 200) {
                    context.read<PokemonListCubit>().loadMore();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (_, index) {
                    final pokemon = state.items[index];
                    return ListTile(
                      leading: Image.network(pokemon.imageUrl, width: 56),
                      title: Text(pokemon.name),
                      subtitle: Text('#${pokemon.id}'),
                      onTap: () {
                        context.go('/pokemon/${pokemon.id}');
                      },
                    );
                  },
                ),
              );
              if (!isWide) {
                return pokemonList;
              }
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: pokemonList,
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
