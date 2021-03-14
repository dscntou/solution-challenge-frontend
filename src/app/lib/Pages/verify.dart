import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:dio/dio.dart';

class VerifyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProfile = (ModalRoute.of(context).settings.arguments as Map);

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Verify your email'),
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
                    text: userProfile['email'],
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextSpan(
                    text: '.',
                  ),
                ],
              ),
            ),
            Center(
                child: VerificationArea(
              code: userProfile['code'],
              email: userProfile['email'],
              name: userProfile['name'],
              encryptedPassword: userProfile['encryptedPassword'],
            )),
          ],
        ),
      ),
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName('/'));
        return false;
      },
    );
  }
}

class VerificationArea extends StatefulWidget {
  final String code;
  final String email;
  final String name;
  final String encryptedPassword;
  VerificationArea(
      {Key key, this.code, this.email, this.encryptedPassword, this.name})
      : super(key: key);

  @override
  _VerificationAreaState createState() => _VerificationAreaState();
}

class _VerificationAreaState extends State<VerificationArea> {
  var _onloading = false;

  void confirm(String value) async {
    setState(() {
      _onloading = true;
    });
    if (widget.code == value) {
      try {
        final _dio = Dio();
        Response response = await _dio.put(
          'http://api.rexwu.tw/api/user/${widget.email}',
          data: {
            'email': widget.email,
            'name': widget.name,
            'password': widget.encryptedPassword,
            'verify': true
          },
        );
        print(response);
        Navigator.pop(context);
      } catch (e) {
        await Future.delayed(Duration(seconds: 3));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Network Error.')));
      }
    } else {
      await Future.delayed(Duration(seconds: 3));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Code not match.')));
    }
    setState(() {
      _onloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Code: ${widget.code}');
    if (_onloading)
      return Center(
        child: SpinKitWave(color: Colors.grey),
      );
    return VerificationCode(
      keyboardType: TextInputType.number,
      length: 4,
      onCompleted: confirm,
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
