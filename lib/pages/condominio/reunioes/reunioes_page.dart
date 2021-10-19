import 'package:cond_app/utils/exports.dart';

class ReunioesPage extends StatefulWidget {
  const ReunioesPage({Key? key}) : super(key: key);

  @override
  _ReunioesPageState createState() => _ReunioesPageState();
}

class _ReunioesPageState extends State<ReunioesPage> {
  List<Reuniao>? reunioes; /*= [
    Reuniao(
        desc: "Reunião para tratar dos projetos do condominio para 2022",
        data: Timestamp.fromDate(DateTime.now())),
    Reuniao(
        desc: "Reunião para tratar dos projetos do condominio para 2022",
        data: Timestamp.fromDate(DateTime(2021, 11, 03))),
    Reuniao(
        desc: "Reunião para tratar dos projetos do condominio para 2022",
        data: Timestamp.fromDate(DateTime(2021, 11, 03))),
    Reuniao(
        desc: "Reunião para tratar dos projetos do condominio para 2022",
        data: Timestamp.fromDate(DateTime(2021, 12, 03))),
    Reuniao(
        desc: "Reunião para tratar dos projetos do condominio para 2022",
        data: Timestamp.fromDate(DateTime(2021, 11, 15))),
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reuniões"),
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: StreamBuilder(
        stream: ReunioesService().stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Não foi possível consultar as reuniões."));
          }

          final data = snapshot.requireData;


          return ReunioesListView(
            reunioes: data,
          );
        }
      ),
    );
  }
}
