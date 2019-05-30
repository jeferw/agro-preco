import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:html/dom.dart' as html;

import 'precos.dart';

Future<List<Preco>> fetchPhotos() async {
  final response = await http.get('http://www.agrosolagricola.com.br/cotacoes');

  return compute(parsePhotos, response.body);
}

List<Preco> parsePhotos(String responseBody) {
  var document = parse(responseBody);
  html.Element tabela = document.getElementById('dataTable');

  List<html.Element> linhas = tabela.querySelectorAll('tbody > tr');
  List<Preco> precos = List<Preco>();

  for (var i = 0; i <= 5; i++) {
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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Agro Preços';

    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Preco>>(
        future: fetchPhotos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Preco> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: photos == null ? 0 : photos.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: ListTile(
              title: Row(children: <Widget>[
            Expanded(child: Text(photos[index].data)),
            Expanded(child: Text(photos[index].preco_milho)),
            Expanded(child: Text(photos[index].preco_soja)),
            Expanded(child: Text(photos[index].preco_trigo)),
          ])),
        );
      }, //itemBuilder
    );
  }
}
