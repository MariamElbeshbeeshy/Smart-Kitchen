import 'package:flutter/material.dart';

class PantryCard extends StatelessWidget {
  final String name;
  final String status;
  final String timeInfo;
  final String image;
  final Color statusColor;
  final Color cardColor;
  final bool showWarning;

  const PantryCard({
    super.key,
    required this.name,
    required this.status,
    required this.timeInfo,
    required this.image,
    required this.statusColor,
    this.cardColor = Colors.white,
    this.showWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
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
          CircleAvatar(radius: 30, backgroundImage: AssetImage(image)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: statusColor),
                ),
                Text(
                  status,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: statusColor.withValues(alpha: 0.7)),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (showWarning) Icon(Icons.warning_rounded, color: statusColor, size: 20),
              Text(
                timeInfo,
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
              ),
              if (!showWarning)
                const Text(
                  'DAYS',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}