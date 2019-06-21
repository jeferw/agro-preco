import 'package:agro_preco/model/precos.dart';
import 'package:flutter/material.dart';

import 'package:agro_preco/get-precos/getPrecosCoopermil.dart';
import 'list-precos/listPrecos.dart';

class PrecosCoopermil extends StatefulWidget {
  @override
  _PrecosCoopermilState createState() => _PrecosCoopermilState();
}

class _PrecosCoopermilState extends State<PrecosCoopermil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preços Coopermil'),
      ),
      body: FutureBuilder<List<Preco>>(
        future: GetPrecosCoopermil().requestProdutos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PrecosList(precos: snapshot.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
