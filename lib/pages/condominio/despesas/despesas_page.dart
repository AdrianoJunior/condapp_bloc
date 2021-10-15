import 'package:cond_app/utils/exports.dart';

class DespesasPage extends StatefulWidget {
  const DespesasPage({Key? key}) : super(key: key);

  @override
  _DespesasPageState createState() => _DespesasPageState();
}

class _DespesasPageState extends State<DespesasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Despesas"),),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    return Container();
  }
}
