import 'package:flutter/material.dart';
import 'package:smart_kitchen/helper/constants.dart';

class PantryInventoryScreen extends StatelessWidget {
  const PantryInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor, // #f5fbef
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor, // #4caf50
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildHeader(),
            const SizedBox(height: 25),
            _buildSearchBar(),
            const SizedBox(height: 25),
            _buildCategoryFilters(),
            const SizedBox(height: 30),
            _buildInventoryList(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Kitchenly',
        style: TextStyle(
          color: kPrimaryColor, // #097622
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage(
              'assets/images/pngtree-women-cartoon-avatar-in-flat-style-png-image_6110776.png',
            ), // Using Mariam's profile image
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pantry Inventory',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.grey, fontSize: 16),
            children: [
              const TextSpan(text: 'You have '),
              TextSpan(
                text: '12 items',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: ' needing attention.'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search your ingredients...',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return Row(
      children: [
        _filterChip('ALL', isSelected: true),
        const SizedBox(width: 10),
        _filterChip('DAIRY'),
        const SizedBox(width: 10),
        _filterChip('PRODUCE'),
      ],
    );
  }

  Widget _filterChip(String label, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? kPrimaryColor : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[600],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInventoryList() {
    // These would typically come from your Cubit state
    return Column(
      children: [
        _inventoryCard(
          name: 'Whole Milk',
          status: 'EXPIRED',
          timeInfo: '2 DAYS AGO',
          image: 'assets/images/milk.png',
          cardColor: const Color(0xFFFFEBEE), // Light red for expired
          statusColor: Colors.red[900]!,
          showWarning: true,
        ),
        _inventoryCard(
          name: 'Strawberries',
          status: 'EXPIRING SOON',
          timeInfo: '1 DAY',
          image: 'assets/images/strawberries.png',
          statusColor: Colors.purple[900]!,
        ),
        _inventoryCard(
          name: 'Asparagus',
          status: 'FRESH',
          timeInfo: '5 DAYS',
          image: 'assets/images/asparagus.png',
          statusColor: kPrimaryColor,
        ),
        // Add more items here...
      ],
    );
  }

  Widget _inventoryCard({
    required String name,
    required String status,
    required String timeInfo,
    required String image,
    required Color statusColor,
    Color cardColor = Colors.white,
    bool showWarning = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 30, backgroundImage: AssetImage(image)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (showWarning)
                Icon(Icons.warning_rounded, color: statusColor, size: 20),
              Text(
                timeInfo,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              if (!showWarning)
                const Text(
                  'DAYS',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
