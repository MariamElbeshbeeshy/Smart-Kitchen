import 'package:flutter/material.dart';
import 'package:smart_kitchen/widgets/pantry_card.dart';
import 'package:smart_kitchen/models/pantry_item_model.dart';

class PantryList extends StatelessWidget {
  final List<PantryItemModel> items;
  const PantryList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), 
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return PantryCard(
          name: item.name,
          status: item.statusText,
          timeInfo: item.timeInfoText,
          image: item.productImage ,
          statusColor: item.statusColor,
          cardColor: item.cardColor,
          showWarning: item.showWarning,
        );
      },
    );
  }
}
