import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../scoped-models/main.dart';

class ProductEditPage extends StatefulWidget {
  final String productId;

  ProductEditPage([this.productId]);

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {

  final Map<String, dynamic> _formData = { 
      'id': null,
      'title': null,
      'description': null,
      'location': null,
      'price': null,
      'image': 'assets/food.jpg'
    };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      initialValue: product != null ? product.title : '',
      decoration: InputDecoration(
        labelText: 'Title'
      ),
      validator: (String value){
        //if anythin gets returned the validation failed 
        if(value == null || value.length < 5){
          return '5 characters minimum';
        }
      },
      onSaved: (String value){
        _formData['title'] = value;
      }
    );
  }

  Widget _buildDescriptionTextField(Product product){
    return TextFormField(
      maxLines: 4,
      initialValue: product != null ? product.description : '',
      decoration: InputDecoration(
        labelText: 'Description',
      ),
      onSaved: (String value){
        _formData['description'] = value;
      }
    );
  } 

  Widget _buildLocationTextField(Product product){
    return TextFormField(
      initialValue: product != null ? product.location : '',
      decoration: InputDecoration(
        labelText: 'location',
      ),
      onSaved: (String value){
        _formData['location'] = value;
      }
    );
  }

  Widget _buildPriceTextField(Product product){
    return TextFormField(
      initialValue: product != null ? product.price.toString() : '',
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Price',
      ),
      validator: (String value){
        if(!RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$').hasMatch(value)){
          return 'only numbers please';
        }
      },
      onSaved: (String value){
        _formData['price'] = double.parse(value);
      }
    );
  }  

  void _submitForm(Product product, Function addProduct, Function updateProduct) {
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();

    Product formProduct = Product(
      id: widget.productId,
      title: _formData['title'],
      description: _formData['description'],
      location: _formData['location'],
      price: _formData['price'],
      createdById: null,
      image: 'assets/food.jpg'
    );

    if(product == null){
      addProduct(formProduct);
    }else{
      updateProduct(formProduct);
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildSubmitButton(Product product){
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        return RaisedButton(
          textColor: Colors.white,
          child: Text('Save'),
          onPressed: () => _submitForm(product, model.addProduct, model.updateProduct)
        );
    });
  }

  Widget _buildPageContent(BuildContext context, [Product product]) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode()); //! removes the keyboard when tap outside form (but if its on a field it gets preference)
      },
      child: Container(
        margin: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildLocationTextField(product),
              _buildPriceTextField(product),
              SizedBox(height: 15.0), //just some space between
              _buildSubmitButton(product)
            ]
          ),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        return  widget.productId == null
          ? _buildPageContent(context)
          : Scaffold(
              appBar: AppBar(title:Text('Edit Product')),
              body: _buildPageContent(context, model.product(widget.productId))
            );
      }
    );
  }
}

// return Center(
//       child: RaisedButton(
//         child: Text('SAVE'),
//         onPressed: (){
//           showModalBottomSheet(
//             context: context,
//             builder: (BuildContext context){
//               return Center(
//                 child: Text('This is a Modal!')
//               );
//             }
//           )
//         }
//       )
//     );