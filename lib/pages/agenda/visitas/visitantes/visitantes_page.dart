import 'package:cond_app/pages/agenda/visitas/visitantes/visitantes_list_view.dart';
import 'package:cond_app/utils/exports.dart';

class VisitantesPage extends StatefulWidget {
  @override
  _VisitantesPageState createState() => _VisitantesPageState();
}

class _VisitantesPageState extends State<VisitantesPage> {
  String? uid;
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user!.uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visitantes"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: StreamBuilder(
          stream: VisitantesService(uid: uid).stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Não foi possível buscar os visitantes."),
              );
            }

            final data = snapshot.requireData;

            return VisitantesListView(
              visitantes: data,
            );
          }),
    );
  }
}
