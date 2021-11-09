import 'package:cond_app/utils/exports.dart';

class ReservaPage extends StatefulWidget {
  Reserva reserva;


  ReservaPage({required this.reserva});

  @override
  _ReservaPageState createState() => _ReservaPageState();
}

class _ReservaPageState extends State<ReservaPage> {

  Reserva get r => widget.reserva;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
