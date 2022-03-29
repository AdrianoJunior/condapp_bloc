import 'dart:convert' as convert;

import 'package:cond_app/utils/exports.dart';

class Visita {
  String? visitaId;
  Timestamp? dataVisita;
  String? nomeVisitante;
  String? RGVisitante;

  Visita({
    this.visitaId,
    this.dataVisita,
    this.nomeVisitante,
    this.RGVisitante,
  });

  Visita.fromMap(Map<String, dynamic> json) {
    visitaId = json['visitaId'];
    dataVisita = json['dataVisita'];
    nomeVisitante  = json['nome'];
    RGVisitante = json['rg'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visitaId'] = visitaId;
    data['dataVisita'] = dataVisita;
    data['nome'] = nomeVisitante;
    data['rg'] = RGVisitante;
    return data;
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }

  @override
  String toString() {
    return 'VISITA{visitante: $nomeVisitante, data: $dataVisita';
  }
}
