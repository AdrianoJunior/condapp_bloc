import 'package:cond_app/utils/exports.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ReservasListView extends StatelessWidget {
  var reservas;

  final f = DateFormat('dd/MM/yyyy - hh:mm');
  final fData = DateFormat('dd/MM/yyyy');

  ReservasListView({Key? key, required this.reservas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reservas != null ? reservas.size : 0,
      itemBuilder: (context, idx) {
        if (reservas == null) {
          return const Center(
              child: Text("Nenhuma reserva feita para os próximos dias."));
        }
        Reserva r = reservas.docs[idx].data();

        return Padding(
          padding: const EdgeInsets.only(top: 4),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Slidable(
              closeOnScroll: true,
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) {
                      push(context, ReservasFormPage(reserva: r,));
                    },
                    icon: Icons.edit,
                    backgroundColor: Colors.green,
                    label: "Editar",
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) {
                      alertCancel(
                        context,
                        "Deseja excluir a sua reserva de: ${r.local}, do dia ${fData.format(r.dataReserva!.toDate())}?"
                        "\nA ação não pode ser desfeita",
                        callback: () {},
                      );
                    },
                    icon: Icons.delete_forever,
                    backgroundColor: Colors.red,
                    label: "Excluir",
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
                          "${r.local}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Data da reserva:",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          f.format(r.dataReserva!.toDate()),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 18,
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
