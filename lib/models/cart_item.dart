class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;
  final String? subtitle;
  final double? originalPrice;

  const CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    this.subtitle,
    this.originalPrice,
  });

  CartItem copyWith({
    String? id,
    String? name,
    double? price,
    int? quantity,
    String? imageUrl,
    String? subtitle,
    double? originalPrice,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      subtitle: subtitle ?? this.subtitle,
      originalPrice: originalPrice ?? this.originalPrice,
    );
  }
}
