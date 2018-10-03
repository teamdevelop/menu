import 'package:flutter/material.dart';
import './pages/mainlist.dart';

import './pages/user.dart';
import './pages/newsDetail.dart';
import './pages/login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '门路',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainList(),
      routes: {
        '': (context) => MainList(),
        '/user': (context) => UserINFO(),
        '/newsDetail' : (context) => NewsDetail(),
        '/login' : (context) => login(),
      },
    );
  }
}

