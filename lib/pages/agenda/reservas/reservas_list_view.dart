import 'package:cond_app/utils/exports.dart';
import 'package:intl/intl.dart';

class ReservasListView extends StatelessWidget {
  var reservas;

  final f = DateFormat('dd/MM/yyyy - hh:mm');
  final fData = DateFormat('dd/MM/yyyy');


  ReservasListView({required this.reservas});

  late List<Reserva> reservasUser;


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
                    "Deseja excluir a sua reserva de: ${r.local}, do dia ${fData.format(r.dataReserva!.toDate())}?"
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
                      "${r.local}",
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
                            text: "Data da reserva: ",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: f.format(
                              r.dataReserva!.toDate(),
                            ),
                            style: const TextStyle(color: Colors.black),
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
        );
      },
    );
  }
}