import 'package:cond_app/utils/exports.dart';

class ReunioesPage extends StatefulWidget {
  const ReunioesPage({Key? key}) : super(key: key);

  @override
  _ReunioesPageState createState() => _ReunioesPageState();
}

class _ReunioesPageState extends State<ReunioesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reuniões"),),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    return Container();
  }
}
