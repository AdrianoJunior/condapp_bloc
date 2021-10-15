import 'package:cond_app/utils/exports.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastre-se"),),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    return Container();
  }
}
