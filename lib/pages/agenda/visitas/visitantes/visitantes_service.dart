import 'package:cond_app/utils/exports.dart';

class VisitantesService {
  String? uid;


  VisitantesService({required this.uid});

  CollectionReference get _reunioes =>
      FirebaseFirestore.instance.collection('users/$uid/visitantes').withConverter<Visitante>(
            fromFirestore: (snapshots, _) => Visitante.fromMap(snapshots.data()!),
            toFirestore: (visitante, _) => visitante.toMap(),
          );

  Stream<QuerySnapshot> get stream => _reunioes.orderBy('nome').snapshots();
}
