import 'package:dio/dio.dart';
import 'package:draftea_pokedex/feature/pokemon/data/dto/pokemon_detail_dto.dart';
import 'package:draftea_pokedex/feature/pokemon/data/dto/pokemon_list_item_dto.dart';

class PokemonApi {
  final Dio dio;

  PokemonApi(this.dio);

  Future<List<PokemonListItemDto>> fetchList({
    required int limit,
    required int offset,
  }) async {
    final response = await dio.get(
      '/pokemon',
      queryParameters: {
        'limit': limit,
        'offset': offset,
      },
    );

    return (response.data['results'] as List).map((e) => PokemonListItemDto.fromMap(e)).toList();
  }

  Future<PokemonDetailDto> fetchDetail(int id) async {
    final response = await dio.get('/pokemon/$id');
    return PokemonDetailDto.fromMap(response.data);
  }
}
