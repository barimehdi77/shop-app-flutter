import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  CartItem(
      {@required this.id,
      @required this.productId,
      @required this.title,
      @required this.price,
      @required this.quantity});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (directiom) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        color: Theme.of(context).colorScheme.error,
        margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        padding: EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.onError,
          size: 40,
        ),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 7,
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
      ),
    );
  }
}
