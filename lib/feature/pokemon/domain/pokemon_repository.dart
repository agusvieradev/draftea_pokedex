import 'package:draftea_pokedex/feature/pokemon/domain/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemonList({
    required int limit,
    required int offset,
  });

  Future<Pokemon> getPokemonDetail(int id);
}
