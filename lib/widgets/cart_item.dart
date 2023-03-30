import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.quantity});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text('\$${price}'),
              ),
            ),
          ),
          title: Text(title),
          // subtitle: Chip(
          //   label: Text(
          //     '\$${price * quantity}',
          //     style: TextStyle(
          //       color: Theme.of(context).primaryTextTheme.titleLarge.color,
          //     ),
          //   ),
          //   backgroundColor: Theme.of(context).primaryColor,
          // ),
          subtitle: Text('Total: \$${(price * quantity)}'),
          trailing: Text('${quantity} X'),
        ),
      ),
    );
  }
}
