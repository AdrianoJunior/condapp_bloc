import 'package:cond_app/utils/exports.dart';
import 'package:intl/intl.dart';

class ReservasBloc extends SimpleBloc<bool> {


  Future<ApiResponse> addReserva(
      {required Reserva reserva}) async {
    try {
      FirebaseFirestore.instance
          .collection('reservas')
          .add(reserva.toMap())
          .then((value) {
        reserva.reservaId = value.id;
        FirebaseFirestore.instance
            .collection('reservas')
            .doc(value.id)
            .set(reserva.toMap());
      });

      return ApiResponse.ok(result: true);
    } catch (e) {
      print(e.toString());
      return ApiResponse.error(
          msg: "Não foi possível salvar a visita, tente novamente!");
    }
  }

  Future<ApiResponse> updateReserva(
      {required Reserva reserva}) async {
    try {
      FirebaseFirestore.instance
          .collection('reservas')
          .doc(reserva.reservaId)
          .update(reserva.toMap()) /*.set(visita.toMap())*/;

      return ApiResponse.ok(result: true);
    } catch (e) {
      print(e.toString());
      return ApiResponse.error(
          msg: "Não foi possível atualizar a reserva, tente novamente!");
    }
  }

  Future<ApiResponse> deleteReserva(
      {required Reserva reserva}) async {
    final f = DateFormat('dd/MM/yyyy');
    try {
      final visitaDoc = FirebaseFirestore.instance
          .collection('reservas')
          .doc(reserva.reservaId);
      await visitaDoc.delete();

      return ApiResponse.ok();
    } catch (e) {
      print(e.toString());
      return ApiResponse.error(
        msg: "Não foi possível excluir a reserva de "
            "${reserva.local} na data "
            "${f.format(reserva.dataReserva!.toDate())}",
      );
    }
  }
  

}