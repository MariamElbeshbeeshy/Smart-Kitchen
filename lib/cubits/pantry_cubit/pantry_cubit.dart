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

  void loadPantryItems() {
    emit(PantryLoadedState(filteredItems: _allItems, selectedCategory: 'ALL'));
  }

  void filterByCategory(String category) {
    if (category == 'ALL') {
      emit(
        PantryLoadedState(filteredItems: _allItems, selectedCategory: 'ALL'),
      );
    } else {
      final filtered = _allItems
          .where((item) => item.category == category)
          .toList();
      emit(
        PantryLoadedState(filteredItems: filtered, selectedCategory: category),
      );
    }
  }
}
