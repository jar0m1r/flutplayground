import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage>{
  String _email = '';
  String _password = '';
  bool _acceptTerms = false;

  bool _showPAssword = false;

  DecorationImage _buildBackgroundImage(){
    return DecorationImage(
      image: AssetImage('assets/background.jpg'),
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop)
      );
  }

  Widget _buildEmailTextField(){
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'email',
        fillColor: Colors.white,
        filled: true
      ),
      onChanged: (String value){
        setState((){
          _email = value;
        });
      }
    );
  }

  Widget _buildPasswordTextField(){
    return TextField(
      obscureText: !_showPAssword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(Icons.remove_red_eye),
          onPressed: (){
            setState((){
              _showPAssword = !_showPAssword;
            });
          }
        ),
        labelText: 'password',
        fillColor: Colors.white,
        filled: true
      ),
      onChanged: (String value){
        setState((){
          _password = value;
        });
      }
    );
  }

  _buildAcceptSwitch(){
    return SwitchListTile(
      title: Text('Accept Terms'),
      value: _acceptTerms,
      onChanged: (bool value){
        setState((){
          _acceptTerms = value;
        });
      }
    );
  }

  void _submitForm(){
    print('logged in with $_email/$_password');
    Navigator.pushReplacementNamed( //so you cannot go back to this page
      context, 
      '/products'
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login')
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage()
        ),
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
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
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  child: Text('LOGIN'),
                  onPressed: _submitForm
                )
              ]
            ),
          ),
        ),
      )
    );
  }
}