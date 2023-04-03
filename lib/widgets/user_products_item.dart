import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductsItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String name;

  const UserProductsItem({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(name),
      trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    EditProductScreen.routeName,
                    arguments: id,
                  );
                },
                icon: Icon(Icons.edit,
                    color: Theme.of(context).colorScheme.primary),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<Products>(context, listen: false).removeProduct(id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          )),
    );
  }
}
