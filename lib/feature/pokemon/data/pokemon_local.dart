import 'package:draftea_pokedex/feature/pokemon/domain/pokemon.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PokemonLocal {
  final Box box;

  PokemonLocal(this.box);

  Future<void> saveList(List<Pokemon> list) async {
    await box.put(
      'list',
      list.map((e) => {
        'id': e.id,
        'name': e.name,
        'imageUrl': e.imageUrl,
        'height': e.height,
        'weight': e.weight,
        'stats': e.stats,
        'types': e.types,
      }).toList(),
    );
  }

  List<Pokemon> loadList() {
    final rawList = box.get('list');
    if (rawList == null) return [];
    return (rawList as List).map((e) {
      return Pokemon(
        id: e['id'],
        name: e['name'],
        imageUrl: e['imageUrl'],
        height: e['height'] ?? 0,
        weight: e['weight'] ?? 0,
        stats: Map<String, int>.from(e['stats'] ?? {}),
        types: List<String>.from(e['types'] ?? []),
      );
    }).toList();
  }

  Future<void> saveDetail(Pokemon pokemon) async {
    await box.put('detail_${pokemon.id}', {
      'id': pokemon.id,
      'name': pokemon.name,
      'imageUrl': pokemon.imageUrl,
      'height': pokemon.height,
      'weight': pokemon.weight,
      'stats': pokemon.stats,
      'types': pokemon.types,
    });
  }

  Pokemon? loadDetail(int id) {
    final rawDetail = box.get('detail_$id');
    if (rawDetail == null) return null;
    return Pokemon(
      id: rawDetail['id'],
      name: rawDetail['name'],
      imageUrl: rawDetail['imageUrl'],
      height: rawDetail['height'] ?? 0,
      weight: rawDetail['weight'] ?? 0,
      stats: Map<String, int>.from(rawDetail['stats'] ?? {}),
      types: List<String>.from(rawDetail['types'] ?? []),
    );
  }
}
