import 'package:draftea_pokedex/feature/pokemon/presentation/cubit/pokemon_list_cubit.dart';
import 'package:draftea_pokedex/feature/pokemon/presentation/cubit/pokemon_list_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (_, index) {
                  final pokemon = state.items[index];
                  return ListTile(
                    leading: Image.network(pokemon.imageUrl, width: 56),
                    title: Text(pokemon.name),
                    subtitle: Text('#${pokemon.id}'),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
