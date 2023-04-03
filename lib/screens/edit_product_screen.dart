import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/user_products_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({Key key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isInit = false;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };
  var _editedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  final _imageUrlController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      var productId = ModalRoute.of(context).settings.arguments;
      if (productId != null) {
        final product = Provider.of<Products>(context, listen: false)
            .findById(ModalRoute.of(context).settings.arguments as String);
        print('prodid = ${product.id}');
        if (product != null) _editedProduct = product;
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
      _isInit = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocusNode.removeListener(_updateImageWhenUnFocus);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
  }

  void _updateImageWhenUnFocus() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    void _saveForm() {
      var isFormValid = _form.currentState.validate();
      if (!isFormValid) return;
      _form.currentState.save();
      print('_editedProduct.id: ${_editedProduct.id}');
      if (_editedProduct.id != null) {
        print('updateProduct');
        Provider.of<Products>(context, listen: false)
            .updateProduct(_editedProduct.id, _editedProduct);
      } else
        Provider.of<Products>(context, listen: false).addProduct(Product(
          id: '${_editedProduct.title}-${DateFormat.yMMMMEEEEd().format(DateTime.now())}',
          title: _editedProduct.title,
          description: _editedProduct.description,
          price: _editedProduct.price,
          imageUrl: _editedProduct.imageUrl,
        ));
      print(_editedProduct);
      Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(7),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(labelText: 'Product Title: '),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty)
                    return 'You need to Enter title of the product!';
                  if (value.length < 3)
                    return 'Title must have at least 3 chars!';
                  return null;
                },
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceFocusNode),
                onSaved: (newValue) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: newValue,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(labelText: 'Product Price: '),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                validator: (value) {
                  if (value.isEmpty) return 'Product Must have Price!';
                  if (double.tryParse(value) == null)
                    return 'You need to enter a valid number';
                  if (double.parse(value) <= 0)
                    return 'Price has to be larger then 0';
                  if (value.endsWith('.'))
                    return 'Please Enter A valud number!';
                  return null;
                },
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
                onSaved: (newValue) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(newValue),
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: InputDecoration(labelText: 'Product Description: '),
                focusNode: _descriptionFocusNode,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value.isEmpty) return 'Product Must have description!';
                  if (value.length < 5)
                    return 'Description Must have at least 5 chars';
                  return null;
                },
                onSaved: (newValue) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: newValue,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              Row(children: [
                Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      right: 7,
                      top: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.contain,
                          )),
                Expanded(
                  child: TextFormField(
                    // initialValue: _initValues['imageUrl'],
                    decoration: InputDecoration(labelText: 'Image URL'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    validator: (value) {
                      if (value.isEmpty) return 'Product Must have a Image!';
                      bool _validURL = Uri.parse(value).isAbsolute;
                      if (!_validURL) return 'Please Enter a valid Image URL!';
                      return null;
                    },
                    onEditingComplete: () {
                      setState(() {});
                    },
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                    onSaved: (newValue) {
                      _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: newValue,
                      );
                    },
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
