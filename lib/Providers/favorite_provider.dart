
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _favoriteMeals = [];

  List<Map<String, dynamic>> get favoriteMeals =>
      [..._favoriteMeals];

  bool isFavorite(String name) {
    return _favoriteMeals.any(
      (meal) => meal['name'] == name,
    );
  }

  void toggleFavorite(Map<String, dynamic> meal) {
    if (isFavorite(meal['name'])) {
      _favoriteMeals.removeWhere(
        (item) => item['name'] == meal['name'],
      );
    } else {
      _favoriteMeals.add(meal);
    }

    notifyListeners();
  }

  void removeFavorite(String name) {
    _favoriteMeals.removeWhere(
      (meal) => meal['name'] == name,
    );

    notifyListeners();
  }
}
