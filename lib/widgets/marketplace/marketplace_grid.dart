import 'package:flutter/material.dart';
import 'package:smart_kitchen/models/marketplace_product.dart';
import 'package:smart_kitchen/widgets/marketplace/marketplace_card.dart';

class MarketplaceGrid extends StatelessWidget {
  final List<MarketplaceProduct> products;
  final Function(MarketplaceProduct) onProductTap;
  final Function(MarketplaceProduct) onAddToCart; 

  const MarketplaceGrid({
    super.key,
    required this.products,
    required this.onProductTap,
    required this.onAddToCart, 
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Text(
            "No products found",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      padding: const EdgeInsets.only(top: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 16,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return MarketplaceCard(
          product: product,
          onTap: () => onProductTap(product),
          onAddToCart: () => onAddToCart(product), 
        );
      },
    );
  }
}
