import 'package:draftea_pokedex/core/ui/ui_constants.dart';
import 'package:flutter/material.dart';

class StatBar extends StatelessWidget {
  final String label;
  final int value;
  final double maxValue;

  const StatBar({
    super.key,
    required this.label,
    required this.value,
    this.maxValue = UiConstants.maxStatValue,
  });

  Color _getBarColor(double percentage) {
    if (percentage > UiConstants.statGoodThreshold) {
      return UiColors.statGreen;
    } else if (percentage > UiConstants.statMediumThreshold) {
      return UiColors.statOrange;
    } else {
      return UiColors.statRed;
    }
  }

  @override
  Widget build(BuildContext context) {
    final percentage = value / maxValue;
    
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
              valueColor: AlwaysStoppedAnimation(
                _getBarColor(percentage),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
