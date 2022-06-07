import 'package:cond_app/pages/condominio/despesas/despesas_list_view.dart';
import 'package:cond_app/pages/condominio/despesas/despesas_service.dart';
import 'package:cond_app/utils/exports.dart';
import 'package:intl/intl.dart';

class DespesasPage extends StatefulWidget {
  const DespesasPage({Key? key}) : super(key: key);

  @override
  _DespesasPageState createState() => _DespesasPageState();
}

class _DespesasPageState extends State<DespesasPage> {
  final f = DateFormat('dd/MM/yyyy');

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
        title: const Text("Despesas"),
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: StreamBuilder(
        stream: DespesasService(uid: uid).stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Não foi possível consultar as suas despesas.",
              ),
            );
          } else if (snapshot.data == null) {
            return const Center(
              child: Text(
                "Nenhuma despesa encontrada.",
              ),
            );
          }

          final data = snapshot.requireData;

          return DespesasListView(despesas: data);
        },
      ),
    );
  }
}
