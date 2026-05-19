import 'package:flutter/material.dart';
import 'package:smart_kitchen/helper/constants.dart';
import 'package:smart_kitchen/models/pantry_item_model.dart';
import 'package:smart_kitchen/widgets/category_filters.dart';
import 'package:smart_kitchen/widgets/custom_appbar.dart';
import 'package:smart_kitchen/widgets/pantry_header.dart';
import 'package:smart_kitchen/widgets/pantry_list.dart';
import 'package:smart_kitchen/widgets/pantry_search_bar.dart';

class PantryInventoryScreen extends StatelessWidget {
  const PantryInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PantryItemModel> dummyPantryItems = [
  PantryItemModel(
    name: 'Whole Milk',
    image: 'assets/images/milk.png',
    category: 'DAIRY',
    quantity: 1,
    expiryDate: DateTime.now().subtract(const Duration(days: 2)), // منتهي منذ يومين
  ),
  PantryItemModel(
    name: 'Strawberries',
    image: 'assets/images/strawberries.png',
    category: 'PRODUCE',
    quantity: 1,
    expiryDate: DateTime.now().add(const Duration(days: 1)), // ينتهي غداً
  ),
  PantryItemModel(
    name: 'Asparagus',
    image: 'assets/images/asparagus.png',
    category: 'PRODUCE',
    quantity: 1,
    expiryDate: DateTime.now().add(const Duration(days: 5)), // طازج
  ),
];
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: const PantryAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            PantryHeader(itemCount: 12),
            SizedBox(height: 25),
            PantrySearchBar(),
            SizedBox(height: 25),
            CategoryFilters(),
            SizedBox(height: 30),
            PantryList(items: dummyPantryItems,),
          ],
        ),
      ),
    );
  }
}
