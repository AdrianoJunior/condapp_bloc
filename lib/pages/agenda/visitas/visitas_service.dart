import 'package:cond_app/pages/agenda/visitas/visita.dart';
import 'package:cond_app/utils/exports.dart';

class VisitasService {

  String? uid;


  VisitasService({required this.uid});

  CollectionReference get _visitas =>
      FirebaseFirestore.instance.collection('users/$uid/visitas').withConverter<Visita>(
        fromFirestore: (snapshots, _) => Visita.fromMap(snapshots.data()!),
        toFirestore: (visita, _) => visita.toMap(),
      );

  Stream<QuerySnapshot> get stream => _visitas.orderBy('dataVisita').snapshots();
}