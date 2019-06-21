import 'package:flutter/material.dart';

import 'agrosol.dart';
import 'coopermil.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agro Preços'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 30, left: 5, right: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ButtonTheme(
                minWidth: double.infinity,
                child: RaisedButton(
                  child: Text(
                    'Preços Agrosol',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrecosAgrosol(),
                      ),
                    );
                  },
                ),
              ),
              ButtonTheme(
                minWidth: double.infinity,
                child: RaisedButton(
                  child: Text(
                    'Preços Coopermil',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrecosCoopermil(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
