import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/cubits/pantry_cubit/pantry_cubit.dart';
import 'package:smart_kitchen/helper/constants.dart';
import 'package:smart_kitchen/widgets/category_filters.dart';
import 'package:smart_kitchen/widgets/custom_appbar.dart';
import 'package:smart_kitchen/widgets/pantry_header.dart';
import 'package:smart_kitchen/widgets/pantry_list.dart';
import 'package:smart_kitchen/widgets/pantry_search_bar.dart';

class PantryInventoryScreen extends StatelessWidget {
  const PantryInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PantryCubit()..loadPantryItems(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: const PantryAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<PantryCubit, PantryState>(
            builder: (context, state) {
              if (state is PantryLoadedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    PantryHeader(itemCount: 12),
                    SizedBox(height: 25),
                    PantrySearchBar(),
                    SizedBox(height: 25),
                    CategoryFilters(
                    selectedCategory: state.selectedCategory,
                    onCategoryChanged: (category) {
                      context.read<PantryCubit>().filterByCategory(category);
                    },
                  ),
                    SizedBox(height: 30),
                    PantryList(items: state.filteredItems),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
