import 'package:cond_app/pages/condominio/despesas/despesa.dart';
import 'package:cond_app/utils/exports.dart';

class DespesasService {

  String? uid;


  DespesasService({required this.uid});

  CollectionReference get _reunioes =>
      FirebaseFirestore.instance.collection('users/$uid/despesas').withConverter<Despesa>(
            fromFirestore: (snapshots, _) => Despesa.fromMap(snapshots.data()!),
            toFirestore: (despesa, _) => despesa.toMap(),
          );

  Stream<QuerySnapshot> get stream => _reunioes.orderBy('dataVencimento').snapshots();
}
