import 'package:cond_app/pages/agenda/visitas/visita.dart';
import 'package:cond_app/pages/agenda/visitas/visitas_bloc.dart';
import 'package:cond_app/pages/agenda/visitas/visitas_form_page.dart';
import 'package:cond_app/utils/exports.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class VisitasListView extends StatelessWidget {
  var visitas;
  final _bloc = VisitasBloc();

  VisitasListView({required this.visitas});

  final f = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: visitas != null ? visitas.size : 0,
      itemBuilder: (context, idx) {
        if (visitas == null) {
          return const Center(
              child: Text("Nenhuma visita marcada para os próximos dias"));
        }
        Visita v = visitas.docs[idx].data();

        return Padding(
          padding: EdgeInsets.only(top: 4),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    flex: 1,
                    icon: Icons.edit,
                    backgroundColor: Colors.green,
                    onPressed: (_) {
                      push(context, VisitasFormPage(visita: v));
                    },
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    flex: 1,
                    icon: Icons.delete_forever,
                    backgroundColor: Colors.red,
                    onPressed: (_) {
                      alertCancel(context,
                          "Deseja excluir a visita de ${v.nomeVisitante} no dia ${f.format(v.dataVisita!.toDate())}?\nATENÇÃO: esta ação não pode ser desfeita",
                          callback: () async {
                        ApiResponse deleteResponse = await _bloc.deleteVisita(
                            visita: v,
                            uid: FirebaseAuth.instance.currentUser!.uid);
                        if (deleteResponse.ok!) {
                          alert(context, 'Visita excluída com sucesso');
                        }
                      });
                    },
                  ),
                ],
              ),
              child: Container(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 8,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          f.format(v.dataVisita!.toDate()),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 16),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Visitante: ",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: v.nomeVisitante,
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "RG: ",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: v.RGVisitante,
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
