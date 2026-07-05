import 'package:flutter/material.dart';

class MarketplaceHeader extends StatelessWidget {
  final int productCount;

  const MarketplaceHeader({
    super.key,
    required this.productCount,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Row(
        children: [
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Marketplace",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  "$productCount Products",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(
               "assets/images/pngtree-women-cartoon-avatar-in-flat-style-png-image_6110776.png",
            ),
          ),
        ],
      ),
    );
  }
}