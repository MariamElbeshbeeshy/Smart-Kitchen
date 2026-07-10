import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:smart_kitchen/models/pantry_item_model.dart';

part 'pantry_state.dart';

class PantryCubit extends Cubit<PantryState> {
  PantryCubit() : super(PantryInitial());
  final Box<PantryItemModel> _pantryBox = Hive.box<PantryItemModel>(
    'pantry_box',
  );

  Timer? _debounceTimer;
  String _currentCategory = 'ALL';
  String _currentQuery = '';

  void loadPantryItems() {
    _applyFilter();
  }

  void updateFilter({String? category, String? query}) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    if (category != null) {
      _currentCategory = category;
      _applyFilter();
    }
    if (query != null) {
      _debounceTimer = Timer(const Duration(milliseconds: 800), () async {
        _currentQuery = query.trim().toLowerCase();
        _applyFilter();
      });
    }
  }

  void _applyFilter() {
    final List<PantryItemModel> allItems = _pantryBox.values.toList();

    List<PantryItemModel> filtered = allItems.where((item) {
      final matchesCategory =
          _currentCategory == 'ALL' || item.category == _currentCategory;
      final matchesSearch = item.name.toLowerCase().contains(_currentQuery);
      return matchesCategory && matchesSearch;
    }).toList();

    emit(
      PantryLoadedState(
        filteredItems: filtered,
        selectedCategory: _currentCategory,
        searchQuery: _currentQuery,
      ),
    );
  }

  void addPantryItem(PantryItemModel newItem) async {
    await _pantryBox.add(newItem);
    _applyFilter();
  }

  void deletePantryItem(dynamic itemKey) async {
    await _pantryBox.delete(itemKey);
    _applyFilter();
  }

  void updatePantryItem({
    required PantryItemModel itemToUpdate,
    required dynamic itemKey,
    required int newQuantity,
  }) async {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    if (itemKey is! String && itemKey is! int) {
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 800), () async {
      final updatedItem = itemToUpdate.copyWith(quantity: newQuantity);
      await _pantryBox.put(itemKey, updatedItem);
      _applyFilter();
    });
  }
}
