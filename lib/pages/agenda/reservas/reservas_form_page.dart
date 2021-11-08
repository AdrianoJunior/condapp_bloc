import 'package:cond_app/utils/exports.dart';
import 'package:intl/intl.dart';

class ReservasFormPage extends StatefulWidget {
  final Reserva? reserva;

  ReservasFormPage({this.reserva});

  @override
  _ReservasFormPageState createState() => _ReservasFormPageState();
}

class _ReservasFormPageState extends State<ReservasFormPage> {
  @override
  void initState() {
    super.initState();

    Intl.defaultLocale = 'pt_BR';
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Reserva? get reserva => widget.reserva;

  int _radioIndex = 0;

  var _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          reserva != null ? "Editar reserva" : "Nova reserva",
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
          const Text(
            "Data",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          DateTimePicker(
            firstDate: DateTime.now(),
            type: DateTimePickerType.date,
            lastDate: DateTime.utc(2022),
            locale: const Locale('pt', 'BR'),
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
            "Salão de festas",
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
      case "Salão de festas":
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
        return "Salão de festas";
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
/*

    // Cria o carro
    var r = reserva ?? Reserva();
    r.nome = tNome.text;
    r.descricao = tDesc.text;
    r.tipo = _getTipo();

    print("Carro: $r");
*/

    setState(() {
      _showProgress = true;
    });

    await Future.delayed(Duration(seconds: 5));
/*
    print("Salvar o carro $r");

    ApiResponse<bool> response = await CarrosApi.save(r, _file);

    if (response.ok) {
      alert(context, "Carro salvo com sucesso", callback: () {
        EventBus.get(context).sendEvent(CarroEvent("carro_salvo", r.tipo));

        pop(context);
      });
    } else {
      alert(context, response.msg);
    }*/

    setState(() {
      _showProgress = false;
    });

    print("Fim.");
  }
}
