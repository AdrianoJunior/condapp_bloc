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
          appBar: AppBar(title: Text("Visitas"),),
          body: _body(),
      drawer: DrawerList(),
        );
  }

  _body() {
    return Container();
  }
}
