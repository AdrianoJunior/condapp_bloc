
import 'package:cond_app/pages/agenda/visitas/visita.dart';
import 'package:cond_app/utils/exports.dart';
import 'package:intl/intl.dart';

class VisitasListView extends StatelessWidget {
  var visitas;

  VisitasListView({required this.visitas});

  final f = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: visitas != null ? visitas.size : 0,
      itemBuilder: (context, idx) {
        if (visitas == null) {
          return const Center(
              child: Text("Nenhuma reunião marcada para os próximos dias"));
        }
        Visita v = visitas.docs[idx].data();

        return Padding(
          padding: const EdgeInsets.only(top: 4),
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
        );
      },
    );
  }
}
