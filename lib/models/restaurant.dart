import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AddOn {
  final String id;
  final String name;
  final double price;
  bool isSelected;

  AddOn({
    required this.id,
    required this.name,
    required this.price,
    this.isSelected = false,
  });

  AddOn copy() => AddOn(
        id: id,
        name: name,
        price: price,
        isSelected: isSelected,
      );
}

class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final bool isPopular;
  final List<AddOn> addOns;

  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isPopular = false,
    this.addOns = const [],
  });
}

class Restaurant {
  final String id;
  final String name;
  final String cuisine;
  final double rating;
  final String time;
  final String distance;
  final String deliveryFee;
  final String imageUrl;
  final String description;
  final List<String> categories;
  final List<MenuItem> menu;
  final bool isRecommended;
  bool isFavorite;

  Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.time,
    required this.distance,
    required this.deliveryFee,
    required this.imageUrl,
    required this.description,
    required this.categories,
    required this.menu,
    this.isRecommended = false,
    this.isFavorite = false,
  });
}

// ── Reusable UI helpers ───────────────────────────────────────────

Widget buildNetworkImage({
  required String url,
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
  BorderRadius? borderRadius,
}) {
  Widget img = Image.network(
    url,
    width: width,
    height: height,
    fit: fit,
    loadingBuilder: (_, child, progress) {
      if (progress == null) return child;
      return Container(
        width: width,
        height: height,
        color: AppTheme.lightGray,
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppTheme.primary,
          ),
        ),
      );
    },
    errorBuilder: (_, __, ___) => Container(
      width: width,
      height: height,
      color: AppTheme.lightGray,
      child: const Icon(
        Icons.restaurant,
        color: AppTheme.primary,
        size: 32,
      ),
    ),
  );

  if (borderRadius != null) {
    return ClipRRect(borderRadius: borderRadius, child: img);
  }
  return img;
}
