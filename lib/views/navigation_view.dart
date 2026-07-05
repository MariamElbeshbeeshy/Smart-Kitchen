import 'package:flutter/material.dart';
import 'package:smart_kitchen/helper/constants.dart';
import 'package:smart_kitchen/views/auth/profile_veiw.dart';
import 'package:smart_kitchen/views/pantry/pantry_view.dart';
import 'package:smart_kitchen/views/marketplace/marketplace_view.dart';
import 'package:smart_kitchen/views/cart/cart_view.dart';

class NavigationView extends StatefulWidget {
  NavigationView({Key? key}) : super(key: key ?? navigationKey);

  static final GlobalKey<NavigationViewState> navigationKey =
      GlobalKey<NavigationViewState>();
  static String id = "navigation view";

  static void changeTab(int index) {
    navigationKey.currentState?.setTab(index);
  }

  @override
  State<NavigationView> createState() => NavigationViewState();
}

class NavigationViewState extends State<NavigationView> {
  int _selectedIndex = 2;

  final List<Widget> _pages = [
    MarketplaceView(),
    const CartView(),
    PantryInventoryScreen(),
    Center(child: Text("welcome in AI Cook")),
    ProfileScreen(),
  ];

  void setTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          //border: BoxBorder.all(color: kPrimaryColor),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(2, 53, 14, 0.2),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: setTab,
            selectedItemColor: kSecondaryColor, // اللون #097622
            unselectedItemColor: kInactiveColor,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.store),
                label: "Marketplace",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory_2_outlined),
                label: "Inventory",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.smart_toy_outlined),
                label: "AI Cook",
              ),
              
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// class NavigationView extends StatefulWidget {

//   const NavigationView({super.key});
//   static String id = "navigation view";

//   @override
//   State<NavigationView> createState() => _NavigationViewState();
// }

// class _NavigationViewState extends State<NavigationView> {
//   int _selectedIndex = 2;
  
//   final List<Widget> _pages=[
//     Center(child: Text("welcome in Home"),) ,
//     Center(child: Text("welcome in Inventory"),) ,
//     Center(child: Text("welcome in AI Cook"),) ,
//     Center(child: Text("welcome in Cart"),) ,
//     Center(child: Text("welcome in Profile"),) ,
//   ];

//   void _onNavItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
  
//       bottomNavigationBar: Container(
//         margin: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
//         decoration: BoxDecoration(
          
//           borderRadius: BorderRadius.circular(40),
//           border: BoxBorder.all(color: kPrimaryColor),
//           boxShadow: [BoxShadow(color:Color.fromRGBO(254, 193, 8, 0.12), blurRadius: 5)],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(40),
//           child: BottomNavigationBar(
//             currentIndex: _selectedIndex,
//             onTap: _onNavItemTapped,
//             items: [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home_filled, color: _selectedIndex == 0 ? kPrimaryColor : Colors.grey),
//                 label: "Home",
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.inventory_2_outlined, color: _selectedIndex == 1 ? kPrimaryColor : Colors.grey),
//                 label: "Inventory",
//               ),

//               BottomNavigationBarItem(
//                 icon: Icon(Icons.smart_toy_outlined, color: _selectedIndex == 2 ? kPrimaryColor : Colors.grey),
//                 label: "AI Cook",
//               ),

//               BottomNavigationBarItem(
//                 icon: Icon(Icons.shopping_cart_outlined, color: _selectedIndex == 3 ? kPrimaryColor : Colors.grey),
//                 label: "Cart",
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person_outline, color: _selectedIndex == 4 ? kPrimaryColor : Colors.grey),
//                 label: "Profile",
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }