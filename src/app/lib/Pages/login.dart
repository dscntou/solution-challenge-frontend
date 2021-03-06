import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'components/bottom_form_button.dart';
import 'components/validator.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

// TODO: validators of email and password
class _LoginFormState extends State<LoginForm> {
  String _email, _password;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  var _dio = Dio();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _login() async {
    var loginForm = _formKey.currentState;
    if (loginForm.validate()) {
      Navigator.of(context).push(
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) {
              return Container(
                color: Colors.grey.withOpacity(0.3),
                child: SpinKitDoubleBounce(color: Colors.grey),
              );
            }),
      );
      loginForm.save();
      print('$_email\n$_password\n\n');
      try {
        Response response;
        // response = await _dio.post('http://api.rexwu.tw/api/user', data:{'email':_email, 'password':});
        print(response);
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed('/home');
      } catch (e) {
        print(e);
        await Future.delayed(Duration(seconds: 3));
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Network Error'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              icon: Icon(Icons.account_circle),
            ),
            onSaved: (val) => _email = val,
            validator: (val) => Validator.email(val),
          ),
          TextFormField(
            obscureText: _obscureText,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Password',
              icon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: _toggle,
              ),
            ),
            onSaved: (val) => _password = val,
            validator: (val) => Validator.password(val),
          ),
          Spacer(),
          Row(children: <Widget>[
            RectengleButton(
                text: 'Sign up',
                color: Colors.amber,
                press: () {
                  Navigator.of(context).pushNamed('/sign_up');
                }),
            RectengleButton(
                text: 'Log in',
                color: Theme.of(context).primaryColor,
                press: () {
                  _login();
                }),
          ]),
        ],
      ),
    );
  }
}
