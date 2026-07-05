import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/cubits/cart_cubit/cart_cubit.dart';
import 'package:smart_kitchen/cubits/cart_cubit/cart_states.dart';
import 'package:smart_kitchen/helper/constants.dart';
import 'package:smart_kitchen/widgets/cart/cart_item_card.dart';
import 'package:smart_kitchen/widgets/cart/environmental_impact_card.dart';
import 'package:smart_kitchen/widgets/cart/order_summary_card.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(
            child: CircularProgressIndicator(color: kPrimaryColor),
          );
        }

        if (state is CartError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is CartLoaded) {
          final items = state.items;

          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xffF1F5F9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Your Cart is empty",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Add some fresh items from the marketplace!",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          int totalQuantity = 0;
          for (final item in items) {
            totalQuantity += item.quantity;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Your Cart",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff1A1A1A),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffEAF6EE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${items.length} ${items.length == 1 ? 'Item' : 'Items'}",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: kSecondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: items.map((item) {
                    return CartItemCard(
                      item: item,
                      onIncrement: () {
                        context.read<CartCubit>().incrementQuantity(item.id);
                      },
                      onDecrement: () {
                        context.read<CartCubit>().decrementQuantity(item.id);
                      },
                      onRemove: () {
                        context.read<CartCubit>().removeItem(item.id);
                      },
                    );
                  }).toList(),
                ),
                EnvironmentalImpactCard(totalItems: totalQuantity),
                OrderSummaryCard(
                  subtotal: state.subtotal,
                  deliveryFee: state.deliveryFee,
                  discount: state.discount,
                  total: state.total,
                  promoCode: state.promoCode,
                  isPromoApplied: state.isPromoApplied,
                  onApplyPromo: (code) {
                    context.read<CartCubit>().applyPromoCode(code);
                  },
                  onRemovePromo: () {
                    context.read<CartCubit>().removePromoCode();
                  },
                  onCheckout: () {
                    Navigator.pushNamed(context, '/checkout');
                  },
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
