import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/bottom_form_button.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
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

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _login() {
    var loginForm = _formKey.currentState;
    if (loginForm.validate()) {
      loginForm.save();
      print('$_email\n$_password\n\n');
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
              press: () {},
            ),
          ]),
        ],
      ),
    );
  }
}
