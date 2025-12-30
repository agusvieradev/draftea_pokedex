import 'package:draftea_pokedex/core/ui/ui_constants.dart';
import 'package:flutter/material.dart';

class PokemonImageSection extends StatelessWidget {
  final String imageUrl;

  const PokemonImageSection({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UiConstants.imageSize,
      height: UiConstants.imageSize,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(UiConstants.imageBorderRadius),
      ),
      child: Image.network(
        imageUrl,
        fit: BoxFit.contain,
      ),
    );
  }
}
