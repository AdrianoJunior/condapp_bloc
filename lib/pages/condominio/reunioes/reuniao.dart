import 'package:cond_app/utils/exports.dart';
import 'dart:convert' as convert;

class Reuniao {
  String? desc;
  Timestamp? data;

  Reuniao({this.desc, this.data});

  Reuniao.fromMap(Map<String, dynamic> map) {
    desc = map['desc'];
    data = map['data'];
  }

  Map<String, dynamic> toMap() {
    return {
      'desc': desc,
      'data': data,
    };
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }

  @override
  String toString() {
    return 'Reunião{desc: $desc, data: ${data!.toDate()}';
  }
}