class PokemonDetailDto {
  final int id;
  final String name;
  final String imageUrl;

  PokemonDetailDto({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory PokemonDetailDto.fromMap(Map<String, dynamic> json) {
    return PokemonDetailDto(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
    );
  }
}
