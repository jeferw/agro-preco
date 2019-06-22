class Preco {
  String data;
  String preco_milho;
  String preco_soja;
  String preco_trigo;
  String tipo; //A Agrosol - C Coopermil

  Preco(
      {this.data,
      this.preco_milho,
      this.preco_soja,
      this.preco_trigo,
      this.tipo});

  factory Preco.fromJson(Map<String, dynamic> json) {
    return Preco(
      data: json['data'] as String,
      preco_milho: json['preco_milho'] as String,
      preco_soja: json['preco_soja'] as String,
      preco_trigo: json['preco_trigo'] as String,
      tipo: json['tipo'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data,
        'preco_milho': preco_milho,
        'preco_soja': preco_soja,
        'preco_trigo': preco_trigo,
        'tipo': tipo,
      };
}
