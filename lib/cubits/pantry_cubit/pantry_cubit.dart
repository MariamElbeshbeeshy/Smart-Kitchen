import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_kitchen/models/pantry_item_model.dart';

part 'pantry_state.dart';

class PantryCubit extends Cubit<PantryState> {
  PantryCubit() : super(PantryInitial());

  final List<PantryItemModel> _allItems = [
    PantryItemModel(
      name: 'Whole Milk',
      image: 'assets/images/milk.png',
      category: 'DAIRY',
      quantity: 1,
      expiryDate: DateTime.now().subtract(const Duration(days: 2)),
    ),
    PantryItemModel(
      name: 'Strawberries',
      image: 'assets/images/strawberries.png',
      category: 'PRODUCE',
      quantity: 1,
      expiryDate: DateTime.now().add(const Duration(days: 1)),
    ),
    PantryItemModel(
      name: 'Asparagus',
      image: 'assets/images/asparagus.png',
      category: 'PRODUCE',
      quantity: 1,
      expiryDate: DateTime.now().add(const Duration(days: 5)),
    ),
  ];

  String _currentCategory = 'ALL';
  String _currentQuery = '';

  void loadPantryItems() {
    emit(
      PantryLoadedState(
        filteredItems: _allItems,
        selectedCategory: 'ALL',
        searchQuery: '',
      ),
    );
  }

  void updateFilter({String? category, String? query}) {
    if (category != null) _currentCategory = category;
    if (query != null) _currentQuery = query.trim().toLowerCase();

    List<PantryItemModel> result = _allItems.where((item) {
      final matchesCategory = _currentCategory == 'ALL' || item.category == _currentCategory;
      final matchesSearch = item.name.toLowerCase().contains(_currentQuery);
      
      return matchesCategory && matchesSearch;
    }).toList();

    emit(PantryLoadedState(
      filteredItems: result,
      selectedCategory: _currentCategory,
      searchQuery: _currentQuery,
    ));
  }
}
