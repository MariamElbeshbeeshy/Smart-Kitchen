import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/cubits/cart_cubit/cart_states.dart';
import 'package:smart_kitchen/models/cart_item.dart';
import 'package:smart_kitchen/models/marketplace_product.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final List<CartItem> _items = [];
  String _promoCode = '';
  bool _isPromoApplied = false;

  void loadCartItems() {
    emit(CartLoading());
    _items.clear();
    _isPromoApplied = false;
    _promoCode = '';
    _updateState();
  }

  void addItem(MarketplaceProduct product, {int quantity = 1}) {
    if (state is! CartLoaded) {
      loadCartItems();
    }
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      final existingItem = _items[index];
      _items[index] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
    } else {
      _items.add(
        CartItem(
          id: product.id,
          name: product.name,
          price: product.price,
          quantity: quantity,
          imageUrl: product.imageName,
          subtitle: product.description.isNotEmpty ? product.description : null,
          originalPrice: product.price,
        ),
      );
    }
    _updateState();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    _updateState();
  }

  void incrementQuantity(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + 1,
      );
      _updateState();
    }
  }

  void decrementQuantity(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0 && _items[index].quantity > 1) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity - 1,
      );
      _updateState();
    }
  }

  void applyPromoCode(String code) {
    if (code.trim().toUpperCase() == 'FRESH2024') {
      _isPromoApplied = true;
      _promoCode = 'FRESH2024';
    } else {
      _isPromoApplied = false;
      _promoCode = '';
    }
    _updateState();
  }

  void removePromoCode() {
    _isPromoApplied = false;
    _promoCode = '';
    _updateState();
  }

  void _updateState() {
    double subtotal = 0.0;
    double discount = 0.0;

    for (final item in _items) {
      final original = item.originalPrice ?? item.price;
      subtotal += original * item.quantity;
      discount += (original - item.price) * item.quantity;
    }

    if (_isPromoApplied) {
      discount += 5.0;
    }

    double deliveryFee = 0.0;
    double total = subtotal - discount + deliveryFee;
    if (total < 0) total = 0.0;

    emit(
      CartLoaded(
        items: List.unmodifiable(_items),
        subtotal: subtotal,
        deliveryFee: deliveryFee,
        discount: discount,
        total: total,
        promoCode: _promoCode,
        isPromoApplied: _isPromoApplied,
      ),
    );
  }
}
