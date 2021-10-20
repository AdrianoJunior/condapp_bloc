import 'package:cond_app/pages/agenda/visitas/visitantes/visitantes_page.dart';
import 'package:cond_app/utils/exports.dart';

class VisitasPage extends StatefulWidget {
  const VisitasPage({Key? key}) : super(key: key);

  @override
  _VisitasPageState createState() => _VisitasPageState();
}

class _VisitasPageState extends State<VisitasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visitas"),
      ),
      body: _body(),
      drawer: DrawerList(),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        elevation: 16,
        spaceBetweenChildren: 8,
        children: [
          SpeedDialChild(
            onTap: () {},
            label: "Cadastrar visitante",
            child: Icon(MaterialIcons.person_add_alt_1),
          ),
          SpeedDialChild(
            onTap: () {
              push(context, VisitantesPage());
            },
            label: "Visitantes",
            child: Icon(MaterialIcons.person_search),
          ),
          SpeedDialChild(
            onTap: () {},
            label: "Nova visita",
            child: Icon(MaterialCommunityIcons.calendar_clock),
          ),
        ],
      ),
    );
  }

  _body() {
    return Container();
  }
}
