import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/user_products_item.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: Padding(
        padding: EdgeInsets.all(7),
        child: ListView.builder(
          itemCount: products.items.length,
          itemBuilder: (_, index) => UserProductsItem(
              name: products.items[index].title,
              imageUrl: products.items[index].imageUrl),
        ),
      ),
    );
  }
}
