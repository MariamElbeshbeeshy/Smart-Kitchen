import 'package:flutter/material.dart';
import 'package:smart_kitchen/helper/constants.dart';
import 'package:smart_kitchen/widgets/cart/cart_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  static const String id = "cart_view";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: kSecondaryColor),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: const Text(
          'Kitchenly',
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(
                'assets/images/pngtree-women-cartoon-avatar-in-flat-style-png-image_6110776.png',
              ),
            ),
          ),
        ],
      ),
      body: const SafeArea(
        child: CartBody(),
      ),
    );
  }
}
