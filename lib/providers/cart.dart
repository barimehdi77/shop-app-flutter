import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  const CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsLength {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (exItem) => CartItem(
            id: exItem.id,
            title: exItem.title,
            quantity: exItem.quantity + 1,
            price: exItem.price),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: '${title}_${DateTime.now()}',
            title: title,
            quantity: 1,
            price: price),
      );
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
