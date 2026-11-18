
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => [
        ..._cartItems,
      ];

  int get totalItems {
    return _cartItems.fold(
      0,
      (sum, item) => sum + (item['quantity'] as int),
    );
  }

  double get subtotal {
    return _cartItems.fold(
      0.0,
      (sum, item) =>
          sum +
          (item['price'] as double) *
              (item['quantity'] as int),
    );
  }

  void addToCart(Map<String, dynamic> meal) {
    final index = _cartItems.indexWhere(
      (item) => item['name'] == meal['name'],
    );

    if (index >= 0) {
      _cartItems[index]['quantity']++;
    } else {
      _cartItems.add({
        ...meal,
        'price': double.parse(meal['price'].toString()),
        'quantity': 1,
      });
    }

    notifyListeners();
  }

  void increaseQuantity(String name) {
    final index = _cartItems.indexWhere(
      (item) => item['name'] == name,
    );

    if (index >= 0) {
      _cartItems[index]['quantity']++;
      notifyListeners();
    }
  }

  void decreaseQuantity(String name) {
    final index = _cartItems.indexWhere(
      (item) => item['name'] == name,
    );

    if (index >= 0) {
      if (_cartItems[index]['quantity'] > 1) {
        _cartItems[index]['quantity']--;
      } else {
        _cartItems.removeAt(index);
      }

      notifyListeners();
    }
  }

  void removeFromCart(String name) {
    _cartItems.removeWhere(
      (item) => item['name'] == name,
    );

    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
