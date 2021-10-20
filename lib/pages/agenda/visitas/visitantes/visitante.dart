import 'package:cond_app/utils/exports.dart';
import 'dart:convert' as convert;

class Visitante {
  String? nome;
  String? rg;
  Timestamp? dataNascimento;

  Visitante({this.nome, this.rg, this.dataNascimento});

  Visitante.fromMap(Map<String, dynamic> map) {
    nome = map['nome'];
    rg = map['RG'];
    dataNascimento = map ['dataNascimento'];
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'RG': rg,
      'dataNascimento': dataNascimento,
    };
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }

  @override
  String toString() {
    return 'Visitante{nome: $nome, data de nascimento: ${dataNascimento!.toDate()}, RG: $rg';
  }
}