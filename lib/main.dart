import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_kitchen/cubits/pantry_cubit/pantry_cubit.dart';
import 'package:smart_kitchen/helper/constants.dart';
import 'package:smart_kitchen/models/pantry_item_model.dart';
import 'package:smart_kitchen/views/navigation_view.dart';
import 'package:smart_kitchen/views/pantry/add_item_view.dart';
import 'package:smart_kitchen/views/pantry/pantry_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_kitchen/firebase_options.dart';
import 'package:smart_kitchen/cubits/marketplace_cubit/marketplace_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(PantryItemModelAdapter());
  await Hive.openBox<PantryItemModel>('pantry_box');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PantryCubit()..loadPantryItems()),

        BlocProvider(create: (context) => MarketplaceCubit()),
      ],
      child: const MainApp(),
    ),
  );
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
