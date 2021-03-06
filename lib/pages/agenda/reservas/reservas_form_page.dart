import 'package:cond_app/utils/exports.dart';
import 'package:intl/intl.dart';

import 'reservas_bloc.dart';

class ReservasFormPage extends StatefulWidget {
  @override
  _ReservasFormPageState createState() => _ReservasFormPageState();
}

class _ReservasFormPageState extends State<ReservasFormPage> {
  @override
  void initState() {
    super.initState();

    Intl.defaultLocale = 'pt_BR';

    _controller3 = TextEditingController(text: DateTime.now().toString());
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _bloc = ReservasBloc();

  int _radioIndex = 0;

  var _showProgress = false;

  String _valueChanged3 = '';
  String _valueToValidate3 = '';
  String _valueSaved3 = '';

  late Timestamp dataReserva;

  late TextEditingController _controller3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nova reserva",
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: _form(),
      ),
    );
  }

  _form() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 250,
            child: _headerFoto(),
          ),
          const SizedBox(height: 16),
          const Text(
            "Local",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          _radioLocal(),
          const Divider(
            thickness: 2,
          ),
          const SizedBox(height: 16),
          /*const Text(
            "Data",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),*/
          const Divider(
            thickness: 2,
          ),
          DateTimePicker(
            type: DateTimePickerType.date,
            //dateMask: 'yyyy/MM/dd',
            controller: _controller3,
            //initialValue: _initialValue,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            icon: const Icon(
              Ionicons.md_calendar,
            ),
            dateLabelText: 'Data',
            locale: const Locale('pt', 'BR'),
            onChanged: (val) async {
              setState(() => _valueChanged3 = val);
              DateTime data = DateTime.parse(_valueChanged3);

              dataReserva = Timestamp.fromDate(data);
            },
            validator: (val) {
              setState(() => _valueToValidate3 = val ?? '');
              return null;
            },
            onSaved: (val) => setState(() => _valueSaved3 = val ?? ''),
          ),
          const Divider(
            thickness: 2,
          ),
          ButtonWidget(
            btnText: "Salvar",
            onClick: _onClickSalvar,
            showProgress: _showProgress,
          )
        ],
      ),
    );
  }

  _headerFoto({BoxFit boxFit = BoxFit.cover}) {
    switch (_radioIndex) {
      case 0:
        return Image.asset(
          'assets/images/salao_festa.jpeg',
          fit: boxFit,
        );
      case 1:
        return Image.asset(
          'assets/images/futebol.jpg',
          fit: boxFit,
        );
      default:
        return Image.asset(
          'assets/images/churrasqueira.jpg',
          fit: boxFit,
        );
    }
  }

  _radioLocal() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ListTile(
          leading: Radio(
            value: 0,
            groupValue: _radioIndex,
            onChanged: _onClickLocal,
          ),
          title: const Text(
            "Sal??o de festas",
            style: TextStyle(color: Colors.blue, fontSize: 15),
          ),
          onTap: () => _onClickLocal(0),
        ),
        ListTile(
          leading: Radio(
            value: 1,
            groupValue: _radioIndex,
            onChanged: _onClickLocal,
          ),
          title: const Text(
            "Campo de futebol",
            style: TextStyle(color: Colors.blue, fontSize: 15),
          ),
          onTap: () => _onClickLocal(1),
        ),
        ListTile(
          leading: Radio(
            value: 2,
            groupValue: _radioIndex,
            onChanged: _onClickLocal,
          ),
          title: const Text(
            "Quiosque/Churrasqueira",
            style: TextStyle(color: Colors.blue, fontSize: 15),
          ),
          onTap: () => _onClickLocal(2),
        ),
      ],
    );
  }

  void _onClickLocal(int? value) {
    setState(() {
      _radioIndex = value!;
    });
  }

  getLocalInt(Reserva reserva) {
    switch (reserva.local) {
      case "Sal??o de festas":
        return 0;
      case "Campo de futebol":
        return 1;
      default:
        return 2;
    }
  }

  String _getLocal() {
    switch (_radioIndex) {
      case 0:
        return "Sal??o de festas";
      case 1:
        return "Campo de futebol";
      default:
        return "Quiosque/Churrasqueira";
    }
  }

  _onClickSalvar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Cria a reserva
    var r = Reserva();
    r.local = _getLocal();
    r.dataReserva = dataReserva;
    r.idMorador = FirebaseAuth.instance.currentUser!.uid;

    print("Reserva: ${r.toString()}");

    setState(() {
      _showProgress = true;
    });

    ApiResponse reservaResponse = await _bloc.addReserva(reserva: r);

    if (reservaResponse.ok!) {
      alert(context, "Reserva criada com sucesso!", callback: () {
        setState(() {
          _showProgress = false;
        });
        pop(context);
      });
    } else {
      alert(context, "N??o foi poss??vel salvar a reserva.\nTente novamente!",
          callback: () {
        setState(() {
          _showProgress = false;
        });
      });
    }

    print("Fim.");
  }
}
