import 'package:flutter/material.dart';
import 'Pages/login.dart';
import 'Pages/sign_up.dart';
import 'Pages/verify.dart';
import 'Pages/home.dart';
import 'Pages/choose_role.dart';
// import 'package:flutter_app/Forms/verify.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HI',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo,
      ),
      routes: {
        '/': (_) => LoginPage(),
        '/sign_up': (_) => SignUpPage(),
        '/verify': (_) => VerifyPage(),
        '/home': (_) => HomePage(),
        '/choose_role': (_) => ChooseRolePage(),
      },
      debugShowCheckedModeBanner: false, // 去除右上方Debug標誌
      // home: LoginPage(),
    );
  }
}
