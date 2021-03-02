import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

/*
class VerifyPage extends StatefulWidget {
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  @override
  Widget build(BuildContext context) {
    final email = (ModalRoute.of(context).settings.arguments as Map)['email'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Verifing'),
      ),
      body: Column(
        children: <Widget>[
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
              text: 'A verificatoin email was sent to ',
              children: <TextSpan>[
                TextSpan(
                  text: email,
                  style: TextStyle(color: Colors.blue),
                ),
                TextSpan(
                  text: '.',
                ),
              ],
            ),
          ),
          Center(child: VerificationArea()),
        ],
      ),
    );
  }
}
*/
class VerifyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final email = (ModalRoute.of(context).settings.arguments as Map)['email'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Verifing'),
      ),
      body: Column(
        children: <Widget>[
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
              text: 'A verificatoin email was sent to ',
              children: <TextSpan>[
                TextSpan(
                  text: email,
                  style: TextStyle(color: Colors.blue),
                ),
                TextSpan(
                  text: '.',
                ),
              ],
            ),
          ),
          Center(child: VerificationArea()),
        ],
      ),
    );
  }
}

class VerificationArea extends StatefulWidget {
  @override
  _VerificationAreaState createState() => _VerificationAreaState();
}

class _VerificationAreaState extends State<VerificationArea> {
  @override
  Widget build(BuildContext context) {
    return VerificationCode(
      // textStyle: TextStyle(fontSize: 20.0, color: Colors.red[900]),
      // underlineColor: Colors.amber,
      keyboardType: TextInputType.number,
      length: 4,
      clearAll: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'clear all',
          style: TextStyle(
              fontSize: 14.0,
              decoration: TextDecoration.underline,
              color: Colors.blue[700]),
        ),
      ),
      onCompleted: (String value) {
        setState(() {
          print(value);
        });
      },
      onEditing: (bool value) {
        setState(() {});
      },
    );
  }
}

class EmailReceivedAnimation extends StatefulWidget {
  @override
  _EmailReceivedAnimationState createState() => _EmailReceivedAnimationState();
}

class _EmailReceivedAnimationState extends State<EmailReceivedAnimation> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
