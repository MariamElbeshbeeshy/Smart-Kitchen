import 'package:flutter/material.dart';
import 'package:smart_kitchen/helper/constants.dart';

class PantryHeader extends StatelessWidget {
  final int itemCount;

  const PantryHeader({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pantry Inventory',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.grey, fontSize: 16),
            children: [
              const TextSpan(text: 'You have '),
              TextSpan(
                text: '$itemCount items',
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: ' needing attention.'),
            ],
          ),
        ),
      ],
    );
  }
}