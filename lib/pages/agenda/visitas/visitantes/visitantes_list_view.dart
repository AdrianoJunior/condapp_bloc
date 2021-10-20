import 'package:cond_app/utils/exports.dart';
import 'package:intl/intl.dart';

class VisitantesListView extends StatelessWidget {
  var visitantes;

  VisitantesListView({required this.visitantes});

  final f = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: visitantes != null ? visitantes.size : 0,
      itemBuilder: (context, idx) {
        if (visitantes == null) {
          return const Center(
              child: Text("Nenhuma reunião marcada para os próximos dias"));
        }
        Visitante v = visitantes.docs[idx].data();

        return Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Slidable(
            actionPane: const SlidableDrawerActionPane(),
            actions: [
              IconSlideAction(
                color: Colors.green,
                onTap: () {},
                caption: 'Editar',
                icon: Icons.edit,
              ),
            ],
            secondaryActions: [
              IconSlideAction(
                color: Colors.red,
                caption: 'Excluir',
                onTap: () {
                  alertCancel(
                    context,
                    "Deseja excluir o visitante: ${v.nome}?"
                    "\nA ação não pode ser desfeita",
                    callback: () {},
                  );
                },
                icon: Icons.delete,
              ),
            ],
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
                      "${v.nome}",
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
                            text: "Data de nascimento: ",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: f.format(
                              v.dataNascimento!.toDate(),
                            ),
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
                            text: v.rg,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    /*ButtonBarTheme(
                      data: ButtonBarTheme.of(context),
                      child: ButtonBar(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Confirmar",
                              style: TextStyle(
                                color: Color(0xff3DBF40),
                                fontSize: 16,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Negar",
                              style: TextStyle(
                                color: Color(0xff8F1919),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )*/
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
