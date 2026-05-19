import 'package:flutter/material.dart';
import 'package:smart_kitchen/helper/constants.dart';
import 'package:smart_kitchen/widgets/pantry_card.dart';

class PantryList extends StatelessWidget {
  const PantryList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        PantryCard(
          name: 'Whole Milk',
          status: 'EXPIRED',
          timeInfo: '2 DAYS AGO',
          image: 'assets/images/milk.png',
          cardColor: Color(0xFFFFEBEE),
          statusColor: Colors.red,
          showWarning: true,
        ),
        PantryCard(
          name: 'Strawberries',
          status: 'EXPIRING SOON',
          timeInfo: '1 DAY',
          image: 'assets/images/strawberries.png',
          statusColor: Colors.purple,
        ),
        PantryCard(
          name: 'Asparagus',
          status: 'FRESH',
          timeInfo: '5 DAYS',
          image: 'assets/images/asparagus.png',
          statusColor: kPrimaryColor,
        ),
      ],
    );
  }
}

