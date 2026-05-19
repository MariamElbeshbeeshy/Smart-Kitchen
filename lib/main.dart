import 'package:flutter/material.dart';
import 'package:smart_kitchen/views/navigation_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationView());
  }
}
