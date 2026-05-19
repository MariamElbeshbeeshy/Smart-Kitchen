import 'package:flutter/material.dart';

enum PantryStatus { expired, expiringSoon, fresh }

class PantryItemModel {
  final String name;
  final DateTime expiryDate;
  final int quantity;
  final String image;
  final String category;

  const PantryItemModel({
    required this.name,
    required this.expiryDate,
    required this.quantity,
    required this.image,
    required this.category,
  });

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
