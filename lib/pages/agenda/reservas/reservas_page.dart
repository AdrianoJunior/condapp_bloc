import 'package:cond_app/pages/agenda/reservas/reservas_list_view.dart';
import 'package:cond_app/pages/agenda/reservas/reservas_service.dart';
import 'package:cond_app/utils/exports.dart';

class ReservasPage extends StatefulWidget {
  const ReservasPage({Key? key}) : super(key: key);

  @override
  _ReservasPageState createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  String? uid;

  @override
  void initState() {
    super.initState();

    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservas"),
      ),
      body: _body(),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(context, ReservasFormPage());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  _body() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: StreamBuilder(
          stream: ReservasService(uid: uid).stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text("Não foi possível consultar as reuniões."));
            } else if (snapshot.data == null) {
              return const Center(
                  child:
                      Text("Nenhuma reserva encontrada para os próximos dias"));
            }

            final data = snapshot.requireData;

            return ReservasListView(
              reservas: data,
            );
          }),
    );
  }
}
