import 'package:smart_kitchen/models/marketplace_product.dart';

abstract class MarketplaceState {
  const MarketplaceState();
}

class MarketplaceInitial extends MarketplaceState {}


class MarketplaceLoading extends MarketplaceState {}


class MarketplaceError extends MarketplaceState {
  final String message;

  const MarketplaceError(this.message);
}

/// بعد تحميل البيانات
class MarketplaceLoaded extends MarketplaceState {
  final List<MarketplaceProduct> allProducts;
  final List<MarketplaceProduct> filteredProducts;
  final String selectedCategory;

  const MarketplaceLoaded({
    required this.allProducts,
    required this.filteredProducts,
    required this.selectedCategory,
  });

  MarketplaceLoaded copyWith({
    List<MarketplaceProduct>? allProducts,
    List<MarketplaceProduct>? filteredProducts,
    String? selectedCategory,
  }) {
    return MarketplaceLoaded(
      allProducts: allProducts ?? this.allProducts,
      filteredProducts:
          filteredProducts ?? this.filteredProducts,
      selectedCategory:
          selectedCategory ?? this.selectedCategory,
    );
  }
}