import 'package:flutter/material.dart';
import 'components/bottom_form_button.dart';
import 'package:dio/dio.dart';

class ChooseRolePage extends StatefulWidget {
  @override
  _ChooseRolePageState createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends State<ChooseRolePage> {
  String _role;
  Map userProfile;

  Future<void> _askedToConfirm() async {
    switch (await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm'),
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                Text('Are you sure want to be a $_role?'),
              ],
            )),
            actions: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text('Eh...'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(
                  'Yes!',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          );
        })) {
      case true:
        try {
          final _dio = Dio();
          await _dio.put(
              'http://api.rexwu.tw/api/user/${userProfile['email']}',
              data: {
                'email': userProfile['email'],
                'name': userProfile['name'],
                'password': userProfile['encryptedPassword'],
                'role': _role
              });
          Navigator.pop(context);
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Network Error.')));
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    userProfile = (ModalRoute.of(context).settings.arguments as Map);
    return WillPopScope(
        onWillPop: () async {
          Navigator.popUntil(context, ModalRoute.withName('/'));
          return false;
        },
        child: Scaffold(
          appBar: AppBar(title: Text('Choose your role')),
          body: Column(
            children: <Widget>[
              Card(
                  child: ListTile(
                leading: Radio(
                  value: 'mentee',
                  groupValue: _role,
                  onChanged: (val) => setState(() {
                    _role = val;
                  }),
                ),
                title: Text('Mentee'),
                subtitle: Text(
                    'As a mentee, you can find a mentor that help you study whatever you want.'),
              )),
              Card(
                child: ListTile(
                  leading: Radio(
                    value: 'mentor',
                    groupValue: _role,
                    onChanged: (val) => setState(() {
                      _role = val;
                    }),
                  ),
                  title: Text('Mentor'),
                  subtitle: Text(
                      'As a mentor, you will lead mentees to learn about your professional skills.'),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  RectengleButton(
                    text: 'Confirm',
                    color: Theme.of(context).primaryColor,
                    press: _role != null ? _askedToConfirm : null,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
