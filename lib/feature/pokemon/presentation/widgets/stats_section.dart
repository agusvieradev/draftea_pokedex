import 'package:draftea_pokedex/core/ui/ui_constants.dart';
import 'package:flutter/material.dart';

class StatsSection extends StatelessWidget {
  final String title;
  final Map<String, int> stats;
  final bool isPhysical;

  const StatsSection({
    super.key,
    required this.title,
    required this.stats,
    this.isPhysical = false,
  });

  Widget _buildPhysicalStat(String label, double value) {
    return Column(
      children: [
        Text(
          value.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: UiColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: UiTypography.labelSmall,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: UiColors.backgroundColor,
        borderRadius: BorderRadius.circular(UiConstants.cardBorderRadius),
        border: Border.all(color: UiColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: UiTypography.labelLarge,
          ),
          const SizedBox(height: 12),
          if (isPhysical)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPhysicalStat('Height', stats['height']! / 10),
                _buildPhysicalStat('Weight', stats['weight']! / 10),
              ],
            )
          else
            Column(
              children: stats.entries
                  .map((entry) => _buildBattleStat(entry.key, entry.value))
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildBattleStat(String label, int value) {
    final percentage = value / UiConstants.maxStatValue;
    final Color barColor = percentage > UiConstants.statGoodThreshold
        ? UiColors.statGreen
        : percentage > UiConstants.statMediumThreshold
            ? UiColors.statOrange
            : UiColors.statRed;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label.toUpperCase(),
                style: UiTypography.labelMedium,
              ),
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: UiColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 8,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation(barColor),
            ),
          ),
        ],
      ),
    );
  }
}
