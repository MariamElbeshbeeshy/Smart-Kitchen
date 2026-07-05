import 'package:flutter/material.dart';
import 'package:smart_kitchen/helper/constants.dart';
import 'package:smart_kitchen/models/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.asset(
              "assets/images/marketplace/${item.imageUrl}",
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 140,
                color: const Color(0xffF6F3EE),
                child: const Center(
                  child: Icon(Icons.image_outlined, size: 48, color: Colors.grey),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1A1A1A),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onRemove,
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                if (item.subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (item.originalPrice != null &&
                            item.originalPrice! > item.price) ...[
                          Text(
                            "\$${item.originalPrice!.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(height: 2),
                        ],
                        Text(
                          "\$${item.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: kSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xffEFEFEF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: onDecrement,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Icon(Icons.remove, size: 16, color: Colors.black54),
                            ),
                          ),
                          Text(
                            "${item.quantity}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          GestureDetector(
                            onTap: onIncrement,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Icon(Icons.add, size: 16, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
