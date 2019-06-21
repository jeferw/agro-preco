import 'package:flutter/material.dart';

import 'package:agro_preco/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agro Preços',
      home: Home(),
    );
  }
}
