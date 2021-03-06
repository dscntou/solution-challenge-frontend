import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _homeKey = new GlobalKey<ScaffoldState>();
  Map parameters;
  final String name = 'Name';
  final _dio = Dio();
  Map userProfile;

  Future<Map> getUserProfile() async {
    Response response = await _dio.get(
        'http://api.rexwu.tw/api/user/${parameters['email']}',
        queryParameters: {'Token': parameters['token']});
    print(response.data);
  }

  @override
  Widget build(BuildContext context) {
    parameters = (ModalRoute.of(context).settings.arguments as Map);
    getUserProfile();
    return Scaffold(
      key: _homeKey,
      appBar: AppBar(
          title: Text('Home'),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _homeKey.currentState.openDrawer(),
          )),
      drawer: HomeDrawer(name: name),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  final String name;
  HomeDrawer({
    Key key,
    this.name,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
            child: RichText(
              text: TextSpan(
                text: 'Hola!',
                // style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[TextSpan(text: name)],
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            )),
        ListTile(
          title: Text('Tile1'),
          onTap: () => {},
        ),
      ],
    ));
  }
}
