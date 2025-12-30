import 'package:draftea_pokedex/core/ui/ui_constants.dart';
import 'package:flutter/material.dart';

class PokemonHeaderSection extends StatelessWidget {
  final String name;
  final int id;
  final List<String> types;

  const PokemonHeaderSection({
    super.key,
    required this.name,
    required this.id,
    required this.types,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name.toUpperCase(),
          style: UiTypography.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(
          '#${id.toString().padLeft(3, '0')}',
          style: UiTypography.titleMedium,
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          children: types
              .map((type) => Chip(
                    label: Text(
                      type.toUpperCase(),
                      style: UiTypography.chipLabel,
                    ),
                    backgroundColor: UiColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
