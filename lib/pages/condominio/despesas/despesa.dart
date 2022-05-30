import 'package:cond_app/utils/exports.dart';
import 'dart:convert' as convert;

class Despesa {
  String? nome;
  double? valor;
  Timestamp? dataVencimento;

  Despesa({this.nome, this.valor, this.dataVencimento});

  Despesa.fromMap(Map<String, dynamic> json) {
    nome = json['nome'];
    valor = json['valor'];
    dataVencimento = json['dataVencimento'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['nome'] = nome;
    data['valor'] = valor;
    data['dataVencimento'] = dataVencimento;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }

  @override
  String toString() {
    return 'Despesa{nome: $nome, data: $dataVencimento, valor: $valor';
  }
}
