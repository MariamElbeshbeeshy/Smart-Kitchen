import 'package:flutter/material.dart';
import 'package:smart_kitchen/helper/constants.dart';
import 'package:smart_kitchen/views/navigation_view.dart';
import 'package:smart_kitchen/views/pantry/add_item_view.dart';
import 'package:smart_kitchen/views/pantry/pantry_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      routes: {
        NavigationView.id: (context) => NavigationView(),
        PantryInventoryScreen.id: (context) => PantryInventoryScreen(),
        AddItemView.id: (context) => AddItemView(),
      },
      initialRoute: NavigationView.id,
    );
  }
}
