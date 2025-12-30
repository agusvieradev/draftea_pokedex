class PokemonListItemDto {
  final String name;
  final String url;

  PokemonListItemDto({
    required this.name,
    required this.url,
  });

  factory PokemonListItemDto.fromMap(Map<String, dynamic> json) {
    return PokemonListItemDto(
      name: json['name'],
      url: json['url'],
    );
  }

  int get id => int.parse(url.split('/').where((e) => e.isNotEmpty).last);
}
