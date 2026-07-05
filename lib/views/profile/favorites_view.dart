import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/cubits/favorites_cubit.dart'; // Wait, let's make sure it imports the cubit
import 'package:smart_kitchen/cubits/cart_cubit/cart_cubit.dart';
import 'package:smart_kitchen/helper/constants.dart';
import 'package:smart_kitchen/models/marketplace_product.dart';
import 'package:smart_kitchen/widgets/marketplace/marketplace_card.dart';
import 'package:smart_kitchen/views/marketplace/product_details_view.dart';
import 'package:smart_kitchen/helper/cart_notification_helper.dart';
import 'package:smart_kitchen/views/navigation_view.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  static const String id = 'favorites_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FBF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kSecondaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Favorite Recipes',
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: BlocBuilder<FavoritesCubit, List<MarketplaceProduct>>(
        builder: (context, favorites) {
          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Color(0xffF1F5F9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_outline_rounded,
                      size: 44,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "No Favorite Recipes Yet",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Explore our marketplace and tap the heart icon to add recipes to your favorites!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.4),
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 16,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final product = favorites[index];
              return MarketplaceCard(
                product: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailsView(product: product),
                    ),
                  );
                },
                onAddToCart: () {
                  context.read<CartCubit>().addItem(product);
                  showCartNotification(context, product.name, onViewPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    NavigationView.changeTab(3);
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
