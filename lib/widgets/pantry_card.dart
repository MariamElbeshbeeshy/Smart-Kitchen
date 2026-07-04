import 'package:flutter/material.dart';
import 'package:smart_kitchen/models/pantry_item_model.dart';
import 'package:smart_kitchen/views/pantry/pantry_item_details_view.dart';

class PantryCard extends StatelessWidget {
  final PantryItemModel item;

  const PantryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PantryItemDetailsView(product: item),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: item.cardColor,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(item.productImage),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: item.statusColor,
                    ),
                  ),
                  Text(
                    item.status.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: item.statusColor.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (item.showWarning)
                  Icon(
                    Icons.warning_rounded,
                    color: item.statusColor,
                    size: 20,
                  ),
                Text(
                  item.timeInfoText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                if (!item.showWarning && item.timeInfoText != "TODAY")
                  const Text(
                    'DAYS',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
