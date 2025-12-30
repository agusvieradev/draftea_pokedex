import 'package:draftea_pokedex/feature/pokemon/domain/pokemon.dart';

sealed class PokemonListState {
  const PokemonListState();
}

class PokemonListLoading extends PokemonListState {
  const PokemonListLoading();
}

class PokemonListLoaded extends PokemonListState {
  final List<Pokemon> items;
  final bool hasMore;

  const PokemonListLoaded({
    required this.items,
    required this.hasMore,
  });
}

class PokemonListError extends PokemonListState {
  final String message;

  const PokemonListError(this.message);
}
