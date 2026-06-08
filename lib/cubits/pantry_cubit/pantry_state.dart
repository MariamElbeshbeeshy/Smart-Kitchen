part of 'pantry_cubit.dart';

@immutable
sealed class PantryState {}

final class PantryInitial extends PantryState {}

class PantryLoadedState extends PantryState {
  final List<PantryItemModel> filteredItems;
  final String selectedCategory;
  final String searchQuery;

  PantryLoadedState({
    required this.filteredItems,
    required this.selectedCategory,
    required this.searchQuery,
  });
}
