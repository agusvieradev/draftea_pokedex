class PokemonDetailDto {
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final Map<String, int> stats;
  final List<String> types;

  PokemonDetailDto({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.stats,
    required this.types,
  });

  factory PokemonDetailDto.fromMap(Map<String, dynamic> json) {
    final types = (json['types'] as List)
        .map((t) => t['type']['name'] as String)
        .toList();
    
    final stats = <String, int>{};
    for (var stat in json['stats'] as List) {
      final statName = stat['stat']['name'] as String;
      final baseStat = stat['base_stat'] as int;
      stats[statName] = baseStat;
    }

    return PokemonDetailDto(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      stats: stats,
      types: types,
    );
  }
}
