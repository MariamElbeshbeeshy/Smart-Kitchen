import 'package:cloud_firestore/cloud_firestore.dart';

class MarketplaceProduct {
  final String id;
  final String name;
  final double price;
  final String category;
  final double rating;
  final int reviews;
  final String market;
  final String description;
  final int stock;
  final String unit;
  final String imageName;

  const MarketplaceProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.rating,
    required this.reviews,
    required this.market,
    required this.description,
    required this.stock,
    required this.unit,
    required this.imageName,
  });

  factory MarketplaceProduct.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return MarketplaceProduct(
      id: doc.id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      category: data['category'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
      reviews: data['reviews'] ?? 0,
      market: data['market'] ?? '',
      description: data['description'] ?? '',
      stock: data['stock'] ?? 0,
      unit: data['unit'] ?? '',
      imageName: data['imageName'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'rating': rating,
      'reviews': reviews,
      'market': market,
      'description': description,
      'stock': stock,
      'unit': unit,
      'imageName': imageName,
    };
  }
}