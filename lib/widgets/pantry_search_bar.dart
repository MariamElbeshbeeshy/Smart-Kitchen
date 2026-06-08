import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/cubits/pantry_cubit/pantry_cubit.dart';

class PantrySearchBar extends StatelessWidget {
  const PantrySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        onChanged: (value) {
          context.read<PantryCubit>().updateFilter(query: value);
        },
        decoration: InputDecoration(
          hintText: 'Search your ingredients...',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}
