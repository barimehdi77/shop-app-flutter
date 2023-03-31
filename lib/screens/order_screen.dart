import 'package:flutter/material.dart';

import '../providers/order.dart' show Order;
import '../widgets/order_item.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Order>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItem(orders.items[i]),
        itemCount: orders.items.length,
      ),
    );
  }
}
