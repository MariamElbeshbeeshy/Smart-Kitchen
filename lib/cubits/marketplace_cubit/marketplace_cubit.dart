import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/cubits/marketplace_cubit/marketplace_states.dart';
import 'package:smart_kitchen/models/marketplace_product.dart';
import 'package:smart_kitchen/services/marketplace_service.dart';

class MarketplaceCubit extends Cubit<MarketplaceState> {
  MarketplaceCubit() : super(MarketplaceInitial());

  final MarketplaceService _service = MarketplaceService();

  /// جميع المنتجات
  List<MarketplaceProduct> _allProducts = [];

  /// تحميل المنتجات من Firebase
  Future<void> loadProducts() async {
    emit(MarketplaceLoading());

    try {
      _allProducts = await _service.getProducts();

      emit(
        MarketplaceLoaded(
          allProducts: _allProducts,
          filteredProducts: _allProducts,
          selectedCategory: "All",
        ),
      );
    } catch (e) {
      emit(MarketplaceError(e.toString()));
    }
  }

  /// البحث
  void searchProducts(String query) {
    if (state is! MarketplaceLoaded) return;

    final currentState = state as MarketplaceLoaded;

    List<MarketplaceProduct> products =
        currentState.allProducts;

    /// لو فيه فلتر شغال
    if (currentState.selectedCategory != "All") {
      products = products.where((product) {
        return product.category ==
            currentState.selectedCategory;
      }).toList();
    }

    if (query.isNotEmpty) {
      products = products.where((product) {
        return product.name
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    }

    emit(
      currentState.copyWith(
        filteredProducts: products,
      ),
    );
  }

  /// الفلترة
  void filterProducts(String category) {
    if (state is! MarketplaceLoaded) return;

    final currentState = state as MarketplaceLoaded;

    List<MarketplaceProduct> products;

    if (category == "All") {
      products = currentState.allProducts;
    } else {
      products = currentState.allProducts.where((product) {
        return product.category == category;
      }).toList();
    }

    emit(
      currentState.copyWith(
        selectedCategory: category,
        filteredProducts: products,
      ),
    );
  }
}