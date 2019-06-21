import 'package:html/dom.dart' as html;

import 'package:agro_preco/model/precos.dart';

abstract class GetPreco {
  Future<List<Preco>> requestProdutos();

  List<Preco> parseProdutos(String responseBody);

  Preco getPreco(html.Element linha);
}
