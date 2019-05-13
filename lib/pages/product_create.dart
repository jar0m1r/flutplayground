import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String _titleValue = '';
  String _descriptionValue = '';
  String _locationValue = '';
  double _priceValue;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Title'
      ),
      validator: (String value){
        //if anythin gets returned the validation failed 
        if(value.isEmpty || value.length < 5){
          return '5 characters minimum';
        }
      },
      onSaved: (String value){
        _titleValue = value;
      }
    );
  }

  Widget _buildDescriptionTextField(){
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(
        labelText: 'Description',
      ),
      onSaved: (String value){
        _descriptionValue = value;
      }
    );
  } 

  Widget _buildLocationTextField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'location',
      ),
      onSaved: (String value){
        _locationValue = value;
      }
    );
  }

  Widget _buildPriceTextField(){
    return TextFormField(
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
        _priceValue = double.parse(value);
      }
    );
  }  

  void _submitForm() {
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();
    final Map<String, dynamic> product = {
      'title': _titleValue,
      'description': _descriptionValue,
      'price': _priceValue,
      'location': _locationValue,
      'image': 'assets/food.jpg'
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
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