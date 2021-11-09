import 'package:cond_app/utils/exports.dart';

class ReservasService {
  String? uid;


  ReservasService({required this.uid});

  CollectionReference get _reservas =>
      FirebaseFirestore.instance.collection('reservas').withConverter<Reserva>(
        fromFirestore: (snapshots, _) => Reserva.fromMap(snapshots.data()!),
        toFirestore: (reserva, _) => reserva.toMap(),
      );

  Stream<QuerySnapshot> get stream => _reservas.orderBy('dataReserva').snapshots();
}