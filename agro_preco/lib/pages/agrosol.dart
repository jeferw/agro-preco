import 'package:agro_preco/model/precos.dart';
import 'package:flutter/material.dart';

import 'package:agro_preco/get-precos/getPrecosAgrosol.dart';

import 'list-precos/listPrecos.dart';

class PrecosAgrosol extends StatefulWidget {
  @override
  _PrecosAgrosolState createState() => _PrecosAgrosolState();
}

class _PrecosAgrosolState extends State<PrecosAgrosol> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preços Agrosol'),
      ),
      body: FutureBuilder<List<Preco>>(
        future: GetPrecosAgrosol().requestProdutos(),
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
