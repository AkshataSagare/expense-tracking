import 'package:flutter/material.dart';

class CategoryEntity {
  String categoryId;
  String name;
  int totalExpenses;
  String icon;

  CategoryEntity({
    required this.categoryId,
    required this.name,
    required this.totalExpenses,
    required this.icon,
  });

  Map<String, Object> toDocument() {
    return {
      'categoryId': categoryId,
      'name': name,
      'totalExpenses': totalExpenses,
      'icon': icon,
    };
  }

  static final Map<String, IconData> iconMap = {
    'Icons.food_bank': Icons.food_bank,
    'Icons.local_grocery_store': Icons.local_grocery_store,
    'Icons.checkroom': Icons.checkroom,
    'Icons.phone_android': Icons.phone_android,
    'Icons.book': Icons.book,
    'Icons.edit': Icons.edit,
    'Icons.mode_of_travel': Icons.mode_of_travel,
    'Icons.smartphone': Icons.smartphone,
    'Icons.lightbulb': Icons.lightbulb,
    'Icons.gas_meter': Icons.gas_meter,
    'Icons.health_and_safety': Icons.health_and_safety,
    'Icons.library_books': Icons.library_books,
    'Icons.local_gas_station_sharp': Icons.local_gas_station_sharp,
    'Icons.movie': Icons.movie,
    'Icons.currency_rupee': Icons.currency_rupee,
  };

  static String getIconString(IconData iconData) {
    final Map<IconData, String> iconNameMap = {
      for (var entry in iconMap.entries) entry.value: entry.key,
    };

    return iconNameMap[iconData] ?? 'Icons.help_outline';
  }

  static IconData getIcon(String iconString) {
    return iconMap[iconString] ?? Icons.help_outline;
  }

  static CategoryEntity fromDocument(Map<String, dynamic> doc) {
    return CategoryEntity(
      categoryId: doc['categoryId'],
      name: doc['name'],
      totalExpenses: doc['totalExpenses'],
      icon: doc['icon'],
    );
  }
}
