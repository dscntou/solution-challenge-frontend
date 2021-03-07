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

// TODO: Use FutureBuilder instead this
  void _login() async {
    var loginForm = _formKey.currentState;
    String token;
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
      var encryptedPassword = sha1.convert(utf8.encode(_password)).toString();
      try {
        Response response;
        response = await _dio.post('http://api.rexwu.tw/api/user/login/',
            data: {'email': _email, 'password': encryptedPassword});
        token = response.data['token'];
      } on DioError catch (e) {
        await Future.delayed(Duration(seconds: 3)); // FOR DEBUG
        switch (e.type) {
          case DioErrorType.RESPONSE:
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Invalid email or password.')));
            break;
          case DioErrorType.DEFAULT:
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Network error.')));
            break;
          case DioErrorType.CONNECT_TIMEOUT:
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Connect timeout.')));
            break;
          case DioErrorType.RECEIVE_TIMEOUT:
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Receive timeout.')));
            break;
          case DioErrorType.CANCEL:
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Request is cancelled.')));
            break;
          case DioErrorType.SEND_TIMEOUT:
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Send timeout.')));
            break;
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Unknown error.')));
      } finally {
        Navigator.of(context).pop();
      }
      if (token != null) {
        Navigator.of(context).pushNamed('/home', arguments: {
          'email': _email,
          'password': encryptedPassword,
          'token': token
        });
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
