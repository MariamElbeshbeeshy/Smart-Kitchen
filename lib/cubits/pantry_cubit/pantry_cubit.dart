import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:hive/hive.dart';
import 'package:smart_kitchen/models/pantry_item_model.dart';

part 'pantry_state.dart';

class PantryCubit extends Cubit<PantryState> {
  PantryCubit() : super(PantryInitial());
  final Box<PantryItemModel> _pantryBox = Hive.box<PantryItemModel>('pantry_box');

  String _currentCategory = 'ALL';
  String _currentQuery = '';

  void loadPantryItems() {
    _applyFilter();
  }

  void updateFilter({String? category, String? query}) {
    if (category != null) _currentCategory = category;
    if (query != null) _currentQuery = query.trim().toLowerCase();
    _applyFilter();
  }

  void _applyFilter() {
    final List<PantryItemModel> allItems = _pantryBox.values.toList();

    List<PantryItemModel> filtered = allItems.where((item) {
      final matchesCategory = _currentCategory == 'ALL' || item.category == _currentCategory;
      final matchesSearch = item.name.toLowerCase().contains(_currentQuery);
      return matchesCategory && matchesSearch;
    }).toList();

    emit(PantryLoadedState(
      filteredItems: filtered,
      selectedCategory: _currentCategory,
      searchQuery: _currentQuery,
    ));
  }

  void addPantryItem(PantryItemModel newItem) async {
    await _pantryBox.add(newItem); 
    _applyFilter(); 
  }

  void deletePantryItem(int index) async {
    await _pantryBox.deleteAt(index);
    _applyFilter();
  }

  void updatePantryItem({
    required PantryItemModel itemToUpdate,
    required String newName,
    required DateTime newExpiryDate,
    required int newQuantity,
    required String newCategory,
    required String newImage,
  }) async {
    
    final updatedItem = itemToUpdate.copyWith(
      name: newName,
      expiryDate: newExpiryDate,
      quantity: newQuantity,
      category: newCategory,
    );
    await _pantryBox.put(itemToUpdate.key, updatedItem);
    _applyFilter();
  }
}
