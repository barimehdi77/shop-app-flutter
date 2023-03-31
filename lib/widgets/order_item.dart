import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/order.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem item;

  OrderItem(this.item);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _extended = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(14),
      child: Column(children: [
        ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text('\$${widget.item.amount}'),
              ),
            ),
          ),
          title: Text(widget.item.id),
          subtitle: Text(
            DateFormat.yMMMMEEEEd().format(widget.item.dateTime),
          ),
          trailing: IconButton(
            icon: Icon(_extended ? Icons.expand_less : Icons.expand_more),
            onPressed: () {
              setState(() {
                _extended = !_extended;
              });
            },
          ),
        ),
        if (_extended)
          Container(
            height: min(widget.item.products.length * 20.0 + 30, 100),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            child: ListView(
              children: widget.item.products
                  .map((elem) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            elem.title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${elem.quantity}x ${elem.price}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ))
                  .toList(),
            ),
          )
      ]),
    );
  }
}
