import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'pantry_item_model.g.dart';

enum PantryStatus { expired, expiringSoon, fresh }

@HiveType(typeId: 0)
class PantryItemModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final DateTime expiryDate;

  @HiveField(2)
  final int quantity;

  @HiveField(3)
  final String category;

  PantryItemModel({
    required this.name,
    required this.expiryDate,
    required this.quantity,
    required this.category,
  });

  PantryItemModel copyWith({
    String? name,
    DateTime? expiryDate,
    int? quantity,
    String? category,
  }) {
    return PantryItemModel(
      name: name ?? this.name,
      expiryDate: expiryDate ?? this.expiryDate,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
    );
  }

  PantryStatus get status {
    final now = DateTime.now();
    final difference = expiryDate
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;

    if (difference < 0) {
      return PantryStatus.expired;
    } else if (difference <= 2) {
      return PantryStatus.expiringSoon;
    } else {
      return PantryStatus.fresh;
    }
  }

  String get statusText {
    switch (status) {
      case PantryStatus.expired:
        return 'EXPIRED';
      case PantryStatus.expiringSoon:
        return 'EXPIRING SOON';
      case PantryStatus.fresh:
        return 'FRESH';
    }
  }

  String get productImage {
    switch (category.toUpperCase()) {
      case 'DAIRY':
        return 'assets/images/milk.jpg';
      case 'PRODUCE':
        return 'assets/images/vegetables.jpg';
      case 'MEAT':
        return 'assets/images/meat.jfif';
      case 'BAKERY':
        return 'assets/images/bakery.jpg';
      default:
        return 'assets/images/food.jpg';
    }
  }

  String get timeInfoText {
    final now = DateTime.now();
    final difference = expiryDate
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
    if (difference < 0) {
      return '${difference.abs()} ${difference.abs() == 1 ? "DAY" : "DAYS"} AGO';
    } else if (difference == 0) {
      return 'TODAY';
    } else {
      return '$difference';
    }
  }

  Color get statusColor {
    switch (status) {
      case PantryStatus.expired:
        return Color(0xffA70138);
      case PantryStatus.expiringSoon:
        return Color(0xff6D3453);
      case PantryStatus.fresh:
        return Color(0xff3E6358);
    }
  }

  Color get cardColor {
    switch (status) {
      case PantryStatus.expired:
        return const Color(0xFFFFEFEF);
      case PantryStatus.expiringSoon:
        return Colors.white;
      case PantryStatus.fresh:
        return Colors.white;
    }
  }

  bool get showWarning => status == PantryStatus.expired;
}
