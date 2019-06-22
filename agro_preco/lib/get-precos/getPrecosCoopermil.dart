import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as html;
import 'package:agro_preco/model/precos.dart';

class GetPrecosCoopermil {
  Future<List<Preco>> requestProdutos() async {
    final response = await http.get('http://www.coopermil.com/cotacao');

    return compute(parseProdutosAut, response.body);
  }

  static Future<List<Preco>> parseProdutosAut(String responseBody) async {
    var document = parse(responseBody);

    DateTime date = new DateTime.now();

    final response =
        await http.post('http://www.coopermil.com/cotacao', headers: {
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
    }, body: {
      '__VIEWSTATE': document.getElementById('__VIEWSTATE').attributes['value'],
      '__VIEWSTATEGENERATOR':
          document.getElementById('__VIEWSTATEGENERATOR').attributes['value'],
      '__EVENTVALIDATION':
          document.getElementById('__EVENTVALIDATION').attributes['value'],
      'ddlMes': date.month.toString(),
      'ddlAno': date.year.toString(),
      'btnSend': 'Consultar'
    });

    return compute(parseProdutos, response.body);
  }

  static List<Preco> parseProdutos(String responseBody) {
    var document = parse(responseBody);

    List<html.Element> areas = document.querySelectorAll('div.cotacoes');

    int qtdePrecos =
        document.querySelector('div.cotacoes').querySelectorAll('li').length;

    List<Preco> precos = List<Preco>();

    for (var i = (qtdePrecos - 1); i >= 0; i--) {
      precos.add(getPreco(i, areas));
    }

    return precos;
  }

  static Preco getPreco(int indice, List<html.Element> areas) {
    Map<String, dynamic> json = new Map<String, dynamic>();

    html.Element areaMilho = areas[0];
    html.Element areaSoja = areas[1];
    html.Element areaTrigo = areas[2];

    json['data'] = areaSoja.querySelectorAll('.indice')[indice].text;
    json['preco_milho'] = areaMilho.querySelectorAll('.valor')[indice].text;
    json['preco_soja'] = areaSoja.querySelectorAll('.valor')[indice].text;
    json['preco_trigo'] = areaTrigo.querySelectorAll('.valor')[indice].text;
    json['tipo'] = 'C';

    return Preco.fromJson(json);
  }
}
