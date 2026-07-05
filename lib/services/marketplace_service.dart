import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_kitchen/models/marketplace_product.dart';

class MarketplaceService {

  final CollectionReference<Map<String, dynamic>>
      _productsCollection =
      FirebaseFirestore.instance.collection("products");

  /// Get All Products
  Future<List<MarketplaceProduct>> getProducts() async {
    final snapshot = await _productsCollection.get();
    return snapshot.docs
        .map((doc) => MarketplaceProduct.fromFirestore(doc))
        .toList();
  }

  /// Get Product By Id
  Future<MarketplaceProduct?> getProductById(String id) async {
    final doc = await _productsCollection.doc(id).get();
    if (!doc.exists) return null;
    return MarketplaceProduct.fromFirestore(doc);
  }

  /// Add Product
  Future<void> addProduct(MarketplaceProduct product) async {
    await _productsCollection.add(product.toFirestore());
  }

  /// Update Product
  Future<void> updateProduct(MarketplaceProduct product) async {
    await _productsCollection.doc(product.id).update(product.toFirestore());
  }

  /// Delete Product
  Future<void> deleteProduct(String id) async {
    await _productsCollection.doc(id).delete();
  }

  /// Seed 10 demo products → Firebase
  Future<void> seedProducts() async {
    final List<Map<String, dynamic>> demoProducts = [
      {
        "name": "Fresh Avocado",
        "price": 2.49,
        "rating": 4.8,
        "category": "Fruits",
        "imageName": "avocado.png",
        "description": "Fresh organic avocados sourced from local farms. Rich in healthy fats and nutrients, perfect for salads and spreads.",
        "market": "Fresh Market",
        "unit": "Piece",
        "reviews": 98,
        "stock": 50,
      },
      {
        "name": "Banana",
        "price": 1.99,
        "rating": 4.5,
        "category": "Fruits",
        "imageName": "banana.png",
        "description": "Sweet and ripe bananas packed with potassium and natural energy. Great for smoothies and snacking.",
        "market": "Fresh Market",
        "unit": "Bundle",
        "reviews": 120,
        "stock": 80,
      },
      {
        "name": "Orange Juice",
        "price": 3.99,
        "rating": 4.6,
        "category": "Drinks",
        "imageName": "orange_juice.png",
        "description": "Freshly squeezed orange juice with no added sugar. A refreshing source of Vitamin C to start your day.",
        "market": "Fresh Market",
        "unit": "Bottle",
        "reviews": 75,
        "stock": 40,
      },
      {
        "name": "Peach",
        "price": 2.99,
        "rating": 4.7,
        "category": "Fruits",
        "imageName": "Peach.jfif",
        "description": "Juicy and sweet peaches picked at peak ripeness. Perfect for desserts, smoothies, or eating fresh.",
        "market": "Fresh Market",
        "unit": "Piece",
        "reviews": 60,
        "stock": 35,
      },
      {
        "name": "Cherry",
        "price": 3.49,
        "rating": 4.9,
        "category": "Fruits",
        "imageName": "Cherry.jfif",
        "description": "Plump and sweet cherries bursting with flavor. Rich in antioxidants and perfect as a healthy snack.",
        "market": "Fresh Market",
        "unit": "Box",
        "reviews": 88,
        "stock": 45,
      },
      {
        "name": "Organic Strawberries",
        "price": 4.29,
        "rating": 4.8,
        "category": "Fruits",
        "imageName": "Strawberries.jfif",
        "description": "Certified organic strawberries grown without pesticides. Sweet, juicy, and perfect for desserts or smoothies.",
        "market": "Fresh Market",
        "unit": "Box",
        "reviews": 145,
        "stock": 60,
      },
      {
        "name": "Fresh Salad",
        "price": 3.19,
        "rating": 4.5,
        "category": "Vegetables",
        "imageName": "Salad.png",
        "description": "A fresh mix of seasonal vegetables carefully selected from local farms. Ready to serve with your favorite dressing.",
        "market": "Fresh Market",
        "unit": "Bowl",
        "reviews": 55,
        "stock": 30,
      },
      {
        "name": "Cucumber",
        "price": 1.49,
        "rating": 4.3,
        "category": "Vegetables",
        "imageName": "cucumber.png",
        "description": "Crisp and refreshing cucumbers straight from the farm. Low in calories and perfect for salads and snacking.",
        "market": "Fresh Market",
        "unit": "Piece",
        "reviews": 42,
        "stock": 70,
      },
      {
        "name": "Tomato",
        "price": 1.99,
        "rating": 4.6,
        "category": "Vegetables",
        "imageName": "tomato.png",
        "description": "Vine-ripened tomatoes with a rich, full flavor. Perfect for salads, sauces, and cooking.",
        "market": "Fresh Market",
        "unit": "Kg",
        "reviews": 110,
        "stock": 65,
      },
      {
        "name": "Whole Milk",
        "price": 3.49,
        "rating": 4.5,
        "category": "Dairy",
        "imageName": "Milk.png",
        "description": "Fresh whole milk from grass-fed cows. Rich in calcium and essential vitamins for a healthy lifestyle.",
        "market": "Fresh Market",
        "unit": "Liter",
        "reviews": 95,
        "stock": 55,
      },
    ];

    final batch = FirebaseFirestore.instance.batch();
    for (final product in demoProducts) {
      final docRef = _productsCollection.doc();
      batch.set(docRef, product);
    }
    await batch.commit();
  }
}