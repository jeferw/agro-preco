import 'dart:async';
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

    String __VIEWSTATE =
        document.getElementById('__VIEWSTATE').attributes['value'];
    String __VIEWSTATEGENERATOR =
        document.getElementById('__VIEWSTATEGENERATOR').attributes['value'];
    String __EVENTVALIDATION =
        document.getElementById('__EVENTVALIDATION').attributes['value'];

    String param = '__VIEWSTATE=' +
        __VIEWSTATE +
        '&__VIEWSTATEGENERATOR=' +
        __VIEWSTATEGENERATOR +
        '&__EVENTVALIDATION=' +
        __EVENTVALIDATION +
        '&ddlMes=1&ddlAno=2019&btnSend=Consultar';

    param = Uri.encodeFull(param);

    final response = await http.post('http://www.coopermil.com/cotacao',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
        },
        body: '__VIEWSTATE=%2FwEPDwULLTIxNDE4OTE4NjgPZBYCAgMPZBYKAgEPEGQPFg1mAgECAgIDAgQCBQIGAgcCCAIJAgoCCwIMFg0QBQRtw6pzZWcQBQdqYW5laXJvBQExZxAFCWZldmVyZWlybwUBMmcQBQZtYXLDp28FATNnEAUFYWJyaWwFATRnEAUEbWFpbwUBNWcQBQVqdW5obwUBNmcQBQVqdWxobwUBN2cQBQZhZ29zdG8FAThnEAUIc2V0ZW1icm8FATlnEAUHb3V0dWJybwUCMTBnEAUIbm92ZW1icm8FAjExZxAFCGRlemVtYnJvBQIxMmdkZAIDDxBkDxYMZgIBAgICAwIEAgUCBgIHAggCCQIKAgsWDBAFA2Fub2VnEAUEMjAxOQUEMjAxOWcQBQQyMDE4BQQyMDE4ZxAFBDIwMTcFBDIwMTdnEAUEMjAxNgUEMjAxNmcQBQQyMDE1BQQyMDE1ZxAFBDIwMTQFBDIwMTRnEAUEMjAxMwUEMjAxM2cQBQQyMDEyBQQyMDEyZxAFBDIwMTEFBDIwMTFnEAUEMjAxMAUEMjAxMGcQBQQyMDA5BQQyMDA5Z2RkAgkPFCsAAmRkZAILDxQrAAJkZGQCDQ8UKwACZGRkGAMFCGx0dlRyaWdvD2dkBQdsdHZTb2phD2dkBQhsdHZNaWxobw9nZGCsR8RviSkMlfNh69CWvosa0RTm&__VIEWSTATEGENERATOR=D75F731D&__EVENTVALIDATION=%2FwEdABsx%2Fm2c1UOlIt7DW5ef%2FXnjKWwtohWFx%2F2GvG08OjV6jATnAGbGFQd88VU4BrNgVafb3e8Trkr6b3THfM29cjdrKzhIXL4%2BBuVrV6SkXp3Lp%2BIhsURnGcuzY58brovvLbvc4Qgoz4R4%2FIg9LOdgkPvVBSDRZDe2QeLtRW%2FUKOhEx4Qn%2ByWHpNG4VH2mmMvLNQVEv3spEU%2FPEgB81b6hK9RKZiDA0QAzsKcxCqGivLzxHcszU%2F04aMxuZcKDdnyo6i8%2B1zOqJswiBTh9xjcSjg228DlTTXKnVTUzroOUiV5sE37ySneZV0ZqIHjScKZ7QFpq9%2FtsJ3v%2FmDaU5%2FiSloc0hLsQEN%2FT2neCiM28D7ZCCFLlh8PSORHZVtoejQb%2FTJ4U78usxlJP8wAYpsvQCPx3KwFvnC%2FfbQlHMab9jJKwS55rke%2FJPLmZ0EjDsj0Uv1BlhXcYb%2FMCi46IUyNqFhtbk3b2rEbOBs8c91oiv12IP5ii6mFZEtU30Jv7Y5hW%2BBPjKei8M5Lu3Rn6oprbQKvti6GJzEO%2F%2BJIljZpmByAX2BKekJuqqgYBm%2FAZmfRxRA4f1CDnitRpJabBX1Q9OV7%2B5QFVFQ%3D%3D&ddlMes=1&ddlAno=2019&btnSend=Consultar'
        );

    print(response.body);

    return null;
    //return compute(parseProdutos, response.body);
  }

  static List<Preco> parseProdutos(String responseBody) {
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

  static Preco getPreco(html.Element linha) {
    List<html.Element> colunas = linha.querySelectorAll('td');

    Map<String, dynamic> json = new Map<String, dynamic>();
    json['data'] = colunas[0].text;
    json['preco_milho'] = colunas[1].text;
    json['preco_soja'] = colunas[2].text;
    json['preco_trigo'] = colunas[3].text;

    return Preco.fromJson(json);
  }
}
