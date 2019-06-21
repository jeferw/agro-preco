import 'package:agro_preco/model/precos.dart';
import 'package:flutter/material.dart';

class PrecosList extends StatelessWidget {
  final List<Preco> precos;

  PrecosList({Key key, this.precos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: precos == null ? 0 : precos.length,
      itemBuilder: (BuildContext context, int index) {
        return getRow(precos[index]);
      }, //itemBuilder
    );
  }

  Widget getRow(Preco produtos) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(produtos.data),
              subtitle: Text('Soja: ' +
                  produtos.preco_soja +
                  '  Trigo: ' +
                  produtos.preco_trigo +
                  '  Milho: ' +
                  produtos.preco_milho),
            ),
          ],
        ),
      ),
    );
  }
}
