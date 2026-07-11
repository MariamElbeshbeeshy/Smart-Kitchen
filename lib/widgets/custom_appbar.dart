import 'package:flutter/material.dart';
import 'package:smart_kitchen/helper/constants.dart';

class PantryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PantryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: "Kitchen",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: kSecondaryColor,
              ),
            ),
            TextSpan(
              text: "ly",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ],
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
