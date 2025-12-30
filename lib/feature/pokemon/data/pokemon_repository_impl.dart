import 'package:draftea_pokedex/core/config/app_config.dart';
import 'package:draftea_pokedex/feature/pokemon/data/pokemon_api.dart';
import 'package:draftea_pokedex/feature/pokemon/data/pokemon_local.dart';
import 'package:draftea_pokedex/feature/pokemon/domain/pokemon.dart';
import 'package:draftea_pokedex/feature/pokemon/domain/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonApi api;
  final PokemonLocal local;

  PokemonRepositoryImpl({
    required this.api,
    required this.local,
  });

  @override
  Future<List<Pokemon>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final list = await api.fetchList(limit: limit, offset: offset);
      final result = list.map((dto) {
        final id = dto.id;
        final imageUrl = '${AppConfig.imageBaseUrl}/$id.png';
        return Pokemon(
          id: id,
          name: dto.name,
          imageUrl: imageUrl,
        );
      }).toList();

      await local.saveList(result);
      return result;
    } catch (_) {
      return local.loadList();
    }
  }

  @override
  Future<Pokemon> getPokemonDetail(int id) async {
    try {
      final dto = await api.fetchDetail(id);
      final pokemon = Pokemon(
        id: dto.id,
        name: dto.name,
        imageUrl: dto.imageUrl,
        height: dto.height,
        weight: dto.weight,
        stats: dto.stats,
        types: dto.types,
      );
      await local.saveDetail(pokemon);
      return pokemon;
    } catch (_) {
      final cached = local.loadDetail(id);
      if (cached != null) return cached;
      rethrow;
    }
  }
}
