import 'package:cond_app/utils/exports.dart';
import 'dart:convert' as convert;

class Reserva {
  String? idMorador;
  double? valor;
  String? local;
  Timestamp? dataEntrada;
  Timestamp? dataSaida;

  Reserva(
      {this.idMorador,
        this.valor,
        this.local,
        this.dataEntrada,
        this.dataSaida});

  Reserva.fromMap(Map<String, dynamic> json) {
    idMorador = json['idMorador'];
    valor = json['valor'];
    local = json['local'];
    dataEntrada = json['dataEntrada'];
    dataSaida = json['dataSaida'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idMorador'] = this.idMorador;
    data['valor'] = this.valor;
    data['local'] = this.local;
    data['dataEntrada'] = this.dataEntrada;
    data['dataSaida'] = this.dataSaida;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }

}
