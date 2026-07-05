import 'package:flutter/material.dart';
import 'package:smart_kitchen/helper/constants.dart';

class MarketplaceSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const MarketplaceSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<MarketplaceSearchBar> createState() =>
      _MarketplaceSearchBarState();
}

class _MarketplaceSearchBarState
    extends State<MarketplaceSearchBar> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Search products...",
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),

          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),

          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    widget.controller.clear();
                    widget.onChanged("");
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                )
              : null,

          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,

          contentPadding:
              const EdgeInsets.symmetric(
            vertical: 16,
          ),
        ),
      ),
    );
  }
}