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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login')
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'email' 
              ),
              onChanged: (String value){
                setState((){
                  _email = value;
                });
              }
            ),
            TextField(
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
                labelText: 'password' 
              ),
              onChanged: (String value){
                setState((){
                  _password = value;
                });
              }
            ),
            SwitchListTile(
              title: Text('Accept Terms'),
              value: _acceptTerms,
              onChanged: (bool value){
                setState((){
                  _acceptTerms = value;
                });
              }
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              child: Text('LOGIN'),
              onPressed: (){
                print('logged in with $_email/$_password');
                Navigator.pushReplacementNamed( //so you cannot go back to this page
                  context, 
                  '/products'
                );
              }
            )
          ]
        ),
      )
    );
  }
}