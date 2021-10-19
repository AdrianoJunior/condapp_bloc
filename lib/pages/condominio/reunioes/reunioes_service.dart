import 'package:cond_app/utils/exports.dart';

class ReunioesService {
  CollectionReference get _reunioes =>
      FirebaseFirestore.instance.collection('reunioes').withConverter<Reuniao>(
            fromFirestore: (snapshots, _) => Reuniao.fromMap(snapshots.data()!),
            toFirestore: (reuniao, _) => reuniao.toMap(),
          );

  Stream<QuerySnapshot> get stream => _reunioes.orderBy('data').snapshots();
}
