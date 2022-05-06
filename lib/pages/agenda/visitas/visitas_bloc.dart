import 'package:cond_app/pages/agenda/visitas/visita.dart';
import 'package:cond_app/utils/exports.dart';
import 'package:intl/intl.dart';

class VisitasBloc extends SimpleBloc<bool> {
  Future<ApiResponse> addVisita(
      {required Visita visita, required String uid}) async {
    try {
      FirebaseFirestore.instance
          .collection('users/$uid/visitas')
          .add(visita.toMap())
          .then((value) {
        visita.visitaId = value.id;
        FirebaseFirestore.instance
            .collection('users/$uid/visitas')
            .doc(value.id)
            .set(visita.toMap());
      });

      return ApiResponse.ok(result: true);
    } catch (e) {
      print(e.toString());
      return ApiResponse.error(
          msg: "Não foi possível salvar a visita, tente novamente!");
    }
  }

  Future<ApiResponse> updateVisita(
      {required Visita visita, required String uid}) async {
    try {
      FirebaseFirestore.instance
          .collection('users/$uid/visitas')
          .doc(visita.visitaId)
          .set(visita.toMap());

      return ApiResponse.ok(result: true);
    } catch (e) {
      print(e.toString());
      return ApiResponse.error(
          msg: "Não foi possível atualizar a visita, tente novamente!");
    }
  }

  Future<ApiResponse> deleteVisita(
      {required Visita visita, required String uid}) async {
    final f = DateFormat('dd/MM/yyyy - hh:mm');
    try {
      final visitaDoc = FirebaseFirestore.instance
          .collection('users/$uid/visitas')
          .doc(visita.visitaId);
      await visitaDoc.delete();

      return ApiResponse.ok();
    } catch (e) {
      print(e.toString());
      return ApiResponse.error(
        msg: "Não foi possível excluir a visita de "
            "${visita.nomeVisitante} na data "
            "${f.format(visita.dataVisita!.toDate())}",
      );
    }
  }
}
