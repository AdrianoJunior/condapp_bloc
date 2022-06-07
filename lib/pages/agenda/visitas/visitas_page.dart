import 'package:cond_app/pages/agenda/visitas/visitas_form_page.dart';
import 'package:cond_app/pages/agenda/visitas/visitas_list_view.dart';
import 'package:cond_app/pages/agenda/visitas/visitas_service.dart';
import 'package:cond_app/utils/exports.dart';

class VisitasPage extends StatefulWidget {
  const VisitasPage({Key? key}) : super(key: key);

  @override
  _VisitasPageState createState() => _VisitasPageState();
}

class _VisitasPageState extends State<VisitasPage> {
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
        title: const Text("Visitas"),
      ),
      body: _body(),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, '/visitas/cadastrar/');
        },
      ),
    );
  }

  _body() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: StreamBuilder(
          stream: VisitasService(uid: uid).stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text(
                "Não foi possível consultar as suas visitas agendadas.",
              ));
            }

            final data = snapshot.requireData;

            return VisitasListView(
              visitas: data,
            );
          }),
    );
  }
}

/*SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        elevation: 16,
        spaceBetweenChildren: 8,
        children: [
          SpeedDialChild(
            onTap: () {},
            label: "Cadastrar visitante",
            child: const Icon(MaterialIcons.person_add_alt_1),
          ),
          SpeedDialChild(
            onTap: () {
              push(context, VisitantesPage());
            },
            label: "Visitantes",
            child: const Icon(MaterialIcons.person_search),
          ),
          SpeedDialChild(
            onTap: () {},
            label: "Nova visita",
            child: const Icon(MaterialCommunityIcons.calendar_clock),
          ),
        ],
      ),*/
