import 'package:flutter/material.dart';
import 'package:smart_kitchen/helper/constants.dart';

class EnvironmentalImpactCard extends StatelessWidget {
  final int totalItems;

  const EnvironmentalImpactCard({
    super.key,
    required this.totalItems,
  });

  @override
  Widget build(BuildContext context) {
    if (totalItems <= 0) return const SizedBox();

    final double co2Saved = totalItems * 0.3;
    final int trees = (totalItems / 2).floor().clamp(1, 99);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xffEAF6EE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xffD0EFE0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.eco,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Environmental Impact",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Your purchase saves ${co2Saved.toStringAsFixed(1)}kg of CO2.",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1A1A1A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Equivalent to planting $trees small ${trees == 1 ? 'tree' : 'trees'} this week.",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
