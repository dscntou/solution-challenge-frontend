import 'package:flutter/material.dart';

class ChooseRolePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Some Text.')));
        return false;
      },
      child: Scaffold(
/*
        appBar: AppBar(
          title: Text('Choose your role!'),
          leading: const Icon(Icons.person),
        ),
*/
        body: Row(
          children: <Widget>[
            Expanded(child: Container(color: Colors.blue)),
            Expanded(child: Container(color: Colors.yellow)),
          ],
        ),
      ),
    );
  }
}
