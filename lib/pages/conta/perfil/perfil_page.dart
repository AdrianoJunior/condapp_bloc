import 'package:cond_app/utils/exports.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Perfil"),),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    return Container();
  }
}
