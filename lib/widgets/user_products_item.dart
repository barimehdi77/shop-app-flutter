import 'dart:math';

import 'package:flutter/material.dart';

class UserProductsItem extends StatelessWidget {
  final String imageUrl;
  final String name;

  const UserProductsItem({@required this.name, @required this.imageUrl});

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
                onPressed: () {},
                icon: Icon(Icons.edit,
                    color: Theme.of(context).colorScheme.primary),
              ),
              IconButton(
                onPressed: () {},
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
