import 'package:flutter/material.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;
  final int productIndex;

  ProductEditPage({this.product, this.productIndex, this.updateProduct, this.addProduct});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = { 
      'title': null,
      'description': null,
      'location': null,
      'price': null,
      'image': 'assets/food.jpg'
    };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      initialValue: widget.product != null ? widget.product['title'] : '',
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

  Widget _buildDescriptionTextField(){
    return TextFormField(
      maxLines: 4,
      initialValue: widget.product != null ? widget.product['description'] : '',
      decoration: InputDecoration(
        labelText: 'Description',
      ),
      onSaved: (String value){
        _formData['description'] = value;
      }
    );
  } 

  Widget _buildLocationTextField(){
    return TextFormField(
      initialValue: widget.product != null ? widget.product['location'] : '',
      decoration: InputDecoration(
        labelText: 'location',
      ),
      onSaved: (String value){
        _formData['location'] = value;
      }
    );
  }

  Widget _buildPriceTextField(){
    return TextFormField(
      initialValue: widget.product != null ? widget.product['price'].toString() : '',
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

  void _submitForm() {
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();

    if(widget.product == null){
      widget.addProduct(_formData);
    }else{
      widget.updateProduct(widget.productIndex, _formData);
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    final Widget pageContent = GestureDetector(
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
              _buildTitleTextField(),
              _buildDescriptionTextField(),
              _buildLocationTextField(),
              _buildPriceTextField(),
              SizedBox(height: 15.0), //just some space between
              RaisedButton(
                textColor: Colors.white,
                child: Text('Save'),
                onPressed: _submitForm
              )
            ]
          ),
        )
      ),
    );
    return widget.product == null
      ? pageContent
      : Scaffold(
        appBar: AppBar(title:Text('Edit Product')),
        body: pageContent
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