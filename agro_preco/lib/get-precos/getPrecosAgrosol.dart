import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as html;
import 'package:agro_preco/model/precos.dart';

//import 'package:agro_preco/get-precos/interfaceGetPrecos.dart';

class GetPrecosAgrosol {
  String URL;

  GetPrecosAgrosol(this.URL);

  Future<List<Preco>> requestProdutos() async {
    final response = await http.get(this.URL);

    //return compute(parseProdutos, response.body);
    return parseProdutos(response.body);
  }

  List<Preco> parseProdutos(String responseBody) {
    var document = parse(responseBody);
    html.Element tabela = document.getElementById('dataTable');

    List<html.Element> linhas = tabela.querySelectorAll('tbody > tr');
    List<Preco> precos = List<Preco>();

    for (var i = 0; i <= 15; i++) {
      precos.add(getPreco(linhas[i]));
    }

    return precos;

    //return linhas.map<Preco>((linha) => getPreco(linha)).toList();
  }

  Preco getPreco(html.Element linha) {
    List<html.Element> colunas = linha.querySelectorAll('td');

    Map<String, dynamic> json = new Map<String, dynamic>();
    json['data'] = colunas[0].text;
    json['preco_milho'] = colunas[1].text;
    json['preco_soja'] = colunas[2].text;
    json['preco_trigo'] = colunas[3].text;

    return Preco.fromJson(json);
  }
}
