import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/helper/constants.dart';
import 'package:smart_kitchen/models/marketplace_product.dart';
import 'package:smart_kitchen/cubits/cart_cubit/cart_cubit.dart';
import 'package:smart_kitchen/helper/cart_notification_helper.dart';
import 'package:smart_kitchen/cubits/favorites_cubit.dart';
import 'package:smart_kitchen/views/navigation_view.dart';



class ProductDetailsView extends StatefulWidget {
  final MarketplaceProduct product;

  const ProductDetailsView({super.key, required this.product});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int quantity = 1;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [

          /// IMAGE
          Expanded(
            flex: 48,
            child: Stack(
              fit: StackFit.expand,
              children: [

                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                  child: Hero(
                    tag: widget.product.id,
                    child: Image.asset(
                      "assets/images/marketplace/${widget.product.imageName}",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0xffF6F3EE),
                        child: const Center(
                          child: Icon(Icons.image_outlined, size: 80, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),

                // Back
                Positioned(
                  top: 50,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 42, height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .08), blurRadius: 8)],
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black87),
                    ),
                  ),
                ),

                Positioned(
                  top: 50,
                  right: 16,
                  child: GestureDetector(
                    onTap: () {
                      final cubit = context.read<FavoritesCubit>();
                      final isCurrentlyFavorite = cubit.isFavorite(widget.product.id);
                      cubit.toggleFavorite(widget.product);
                      showFavoriteNotification(context, widget.product.name, !isCurrentlyFavorite);
                    },
                    child: Container(
                      width: 42, height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .08), blurRadius: 8)],
                      ),
                      child: BlocBuilder<FavoritesCubit, List<MarketplaceProduct>>(
                        builder: (context, favorites) {
                          final isFav = favorites.any((p) => p.id == widget.product.id);
                          return Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            size: 18, color: Colors.redAccent,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// INFO
         Flexible(
            flex: 52,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Name + Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff1A1A1A),
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${widget.product.price.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff2E7D32),
                            ),
                          ),
                          Text(
                            "Per ${widget.product.unit.isEmpty ? "Item" : widget.product.unit}",
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        widget.product.rating.toStringAsFixed(1),
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                      Text(
                        " (${widget.product.reviews} Reviews)",
                        style: const TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Market
                  if (widget.product.market.isNotEmpty)
                    Row(
                      children: [
                        const Icon(Icons.storefront_outlined, size: 17, color: Colors.grey),
                        const SizedBox(width: 6),
                        Text(
                          widget.product.market,
                          style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),

                  const SizedBox(height: 20),

                  // Quantity Container
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xffF8F8F8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "Quantity",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),

                        GestureDetector(
                          onTap: () { if (quantity > 1) setState(() => quantity--); },
                          child: Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .06), blurRadius: 6)],
                            ),
                            child: const Icon(Icons.remove, size: 18),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "$quantity",
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                        ),

                        GestureDetector(
                          onTap: () => setState(() => quantity++),
                          child: Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.add, size: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Description
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),

                  const SizedBox(height: 8),

                  if (widget.product.description.isNotEmpty) ...[
                    Text(
                      widget.product.description,
                      maxLines: isExpanded ? null : 2,
                      overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: () => setState(() => isExpanded = !isExpanded),
                      child: Text(
                        isExpanded ? "Show Less" : "Read More",
                        style: const TextStyle(
                          fontSize: 14,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Total + Add to Cart
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "TOTAL",
                            style: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w600, letterSpacing: 1),
                          ),
                          Text(
                            "\$${(widget.product.price * quantity).toStringAsFixed(2)}",
                            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xff1A1A1A)),
                          ),
                        ],
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            context.read<CartCubit>().addItem(widget.product, quantity: quantity);
                            showCartNotification(
                              context, 
                              widget.product.name,
                              onViewPressed: () {
                                Navigator.pop(context);
                                NavigationView.changeTab(1);
                              },
                            );
                          },
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 22),
                                SizedBox(width: 8),
                                Text(
                                  "Add To Cart",
                                  style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}