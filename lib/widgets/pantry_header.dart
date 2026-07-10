import 'package:flutter/material.dart';
import 'package:smart_kitchen/helper/constants.dart';

class PantryHeader extends StatelessWidget {
  final int itemCount;

  const PantryHeader({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Pantry Inventory',
      style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
    );
  }
}
