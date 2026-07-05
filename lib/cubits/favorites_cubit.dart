import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/models/marketplace_product.dart';

class FavoritesCubit extends Cubit<List<MarketplaceProduct>> {
  FavoritesCubit() : super([]);

  void toggleFavorite(MarketplaceProduct product) {
    final list = List<MarketplaceProduct>.from(state);
    final isAlreadyFavorite = list.any((p) => p.id == product.id);
    
    if (isAlreadyFavorite) {
      list.removeWhere((p) => p.id == product.id);
    } else {
      list.add(product);
    }
    emit(list);
  }

  bool isFavorite(String productId) {
    return state.any((p) => p.id == productId);
  }
}
