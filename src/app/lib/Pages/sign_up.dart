import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/bottom_form_button.dart';

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

  void _signUp() {
    var signUpForm = _formKey.currentState;
    if (signUpForm.validate()) {
      signUpForm.save();
      print('$_name\n$_email\n$_password\n$_confirmPassword');
      Navigator.of(context).pushNamed('/verify', arguments: {'email': _email});
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
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              icon: Icon(Icons.email),
            ),
            onSaved: (val) => _email = val,
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
              if (val != _pass.text) return 'Not Match';
              return null;
            },
          ),
          Spacer(flex: 7),
          RectengleButton(
            text: 'Submit',
            press: _signUp,
          ),
        ],
      ),
    );
  }
}
