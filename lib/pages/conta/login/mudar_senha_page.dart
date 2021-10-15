import 'package:cond_app/utils/exports.dart';

class MudarSenhaPage extends StatefulWidget {
  const MudarSenhaPage({Key? key}) : super(key: key);

  @override
  _MudarSenhaPageState createState() => _MudarSenhaPageState();
}

class _MudarSenhaPageState extends State<MudarSenhaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mudar Senha"),),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    return Container();
  }
}
