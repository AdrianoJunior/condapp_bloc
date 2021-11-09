import 'package:cond_app/utils/exports.dart';
import 'dart:convert' as convert;

class Reserva {
  String? reservaId;
  String? idMorador;
  double? valor;
  String? local;
  Timestamp? dataReserva;

  Reserva({
    this.idMorador,
    this.valor,
    this.local,
    this.dataReserva,
  });

  Reserva.fromMap(Map<String, dynamic> json) {
    reservaId = json['reservaId'];
    idMorador = json['idMorador'];
    valor = json['valor'];
    local = json['local'];
    dataReserva = json['dataReserva'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reservaId'] = this.reservaId;
    data['idMorador'] = this.idMorador;
    data['valor'] = this.valor;
    data['local'] = this.local;
    data['dataReserva'] = this.dataReserva;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }

  @override
  String toString() {
    return 'Reserva{local: $local, data: $dataReserva';
  }
}
