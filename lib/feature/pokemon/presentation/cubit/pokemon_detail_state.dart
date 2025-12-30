import 'package:draftea_pokedex/feature/pokemon/domain/pokemon.dart';

abstract class PokemonDetailState {
  const PokemonDetailState();
}

class PokemonDetailLoading extends PokemonDetailState {
  const PokemonDetailLoading();
}

class PokemonDetailLoaded extends PokemonDetailState {
  final Pokemon pokemon;

  const PokemonDetailLoaded(this.pokemon);
}

class PokemonDetailError extends PokemonDetailState {
  final String message;

  const PokemonDetailError(this.message);
}
