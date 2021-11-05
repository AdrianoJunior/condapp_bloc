import 'package:cond_app/utils/exports.dart';

class ReservasPage extends StatefulWidget {
  const ReservasPage({Key? key}) : super(key: key);

  @override
  _ReservasPageState createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reservas"),),
      body: _body(),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(onPressed: (){}),
    );
  }

  _body() {
    return Container();
  }
}
