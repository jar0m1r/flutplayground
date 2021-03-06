import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage>{
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };
  bool _showPassword = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DecorationImage _buildBackgroundImage(){
    return DecorationImage(
      image: AssetImage('assets/background.jpg'),
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop)
      );
  }

  Widget _buildEmailTextField(){
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'email',
        fillColor: Colors.white,
        filled: true
      ),
      validator: (String value){
        if(value.isEmpty || !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value)){
          return 'fill in a valid email address';
        }
      },
      onSaved: (String value){
          _formData['email'] = value;
      }
    );
  }

  Widget _buildPasswordTextField(){
    return TextFormField(
      obscureText: !_showPassword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(Icons.remove_red_eye),
          onPressed: (){
            setState((){
              _showPassword = !_showPassword;
            });
          }
        ),
        labelText: 'password',
        fillColor: Colors.white,
        filled: true
      ),
      validator: (String value){
        if(value.isEmpty){
          return 'password must be filled';
        }
      },
      onSaved: (String value){
          _formData['password'] = value;
      }
    );
  }

  _buildAcceptSwitch(){
    return SwitchListTile(
      title: Text('Accept Terms'),
      value: _formData['acceptTerms'],
      onChanged: (bool value){
        setState((){
          _formData['acceptTerms'] = value;
        });
      }
    );
  }

  void _submitForm(Function login){
    if(!_formKey.currentState.validate() || !_formData['acceptTerms']){
      return;
    }
    _formKey.currentState.save();
    login(_formData['email'], _formData['password']);
    Navigator.pushReplacementNamed( //so you cannot go back to this page
      context, 
      '/products'
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login')
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage()
        ),
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: targetWidth,
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(),
                    SizedBox(height: 10.0),
                    _buildPasswordTextField(),
                    SizedBox(height: 10.0),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: _buildAcceptSwitch(),
                    ),
                    SizedBox(height: 20.0),
                    ScopedModelDescendant<MainModel>(
                      builder: (BuildContext context, Widget child, MainModel model){
                        return RaisedButton(
                          textColor: Colors.white,
                          child: Text('LOGIN'),
                          onPressed: () => _submitForm(model.login)
                        );
                      }
                    )
                  ]
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}