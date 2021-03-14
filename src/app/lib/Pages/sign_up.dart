import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/bottom_form_button.dart';
import 'components/validator.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SignUpForm(),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String _name, _email, _password, _confirmPassword;
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _comfirmPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Dio _dio = new Dio();

  void _signUp() async {
    var signUpForm = _formKey.currentState;
    if (signUpForm.validate()) {
      signUpForm.save();
      var encryptedPassword = sha1.convert(utf8.encode(_password)).toString();
      print('$_name\n$_email\n$_password\n$_confirmPassword');
      print('$encryptedPassword\n');
      Response response = await _dio.post('http://api.rexwu.tw/api/user/',
          data: {
            'email': _email,
            'password': encryptedPassword,
            'name': _name
          });
      print(response.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Account created. Please check your mailbox.')));
      Navigator.pop(context);
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
              labelText: 'Name',
              icon: Icon(Icons.account_circle),
            ),
            onSaved: (val) => _name = val,
            validator: (val) => Validator.name(val),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              icon: Icon(Icons.email),
            ),
            onSaved: (val) => _email = val,
            validator: (val) => Validator.email(val),
          ),
          TextFormField(
            obscureText: true,
            keyboardType: TextInputType.text,
            controller: _pass,
            decoration: const InputDecoration(
              labelText: 'Password',
              icon: Icon(Icons.lock),
            ),
            onSaved: (val) => _password = val,
            validator: (val) => Validator.password(val),
          ),
          TextFormField(
            obscureText: true,
            keyboardType: TextInputType.text,
            controller: _comfirmPass,
            decoration: const InputDecoration(
              labelText: 'Retype Password',
              icon: Icon(Icons.lock),
            ),
            onSaved: (val) => _confirmPassword = val,
            validator: (val) {
              if (val != _pass.text) return 'Not Match.';
              return null;
            },
          ),
          Spacer(),
          Row(children: <Widget>[
            RectengleButton(
              color: Theme.of(context).primaryColor,
              text: 'Submit',
              press: _signUp,
            ),
          ]),
        ],
      ),
    );
  }
}
