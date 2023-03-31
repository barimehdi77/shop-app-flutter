import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  const OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Order with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items {
    return [..._items];
  }

  void addOrder(List<CartItem> products, double total) {
    _items.insert(
      0,
      OrderItem(
          id: 'order-${DateTime.now()}',
          amount: total,
          products: products,
          dateTime: DateTime.now()),
    );
    notifyListeners();
  }
}
