import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid.dart';
import '../providers/cart.dart';
import '../widgets/cartBadge.dart';

enum PopUpMenuItemValues { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _displayFavoritesOnly = false;
  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          Consumer<Cart>(
            builder: (ctx, cart, ch) => CartBadge(
              child: ch,
              value: cart.itemsLength.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
          PopupMenuButton(
              onSelected: (PopUpMenuItemValues value) {
                print(value);
                if (value == PopUpMenuItemValues.Favorites) {
                  setState(() {
                    if (_displayFavoritesOnly == false)
                      _displayFavoritesOnly = true;
                  });
                  // products.toggleShowFavoritesOnly(true);
                } else {
                  setState(() {
                    if (_displayFavoritesOnly == true)
                      _displayFavoritesOnly = false;
                  });
                  // products.toggleShowFavoritesOnly(false);
                }
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text("Only Favorites"),
                      value: PopUpMenuItemValues.Favorites,
                    ),
                    PopupMenuItem(
                      child: Text("All Items"),
                      value: PopUpMenuItemValues.All,
                    ),
                  ]),
        ],
      ),
      body: ProductsGrid(
        displayFavoritesOnly: _displayFavoritesOnly,
      ),
    );
  }
}
