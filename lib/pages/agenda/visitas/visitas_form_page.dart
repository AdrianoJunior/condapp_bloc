import 'package:cond_app/pages/agenda/visitas/visita.dart';
import 'package:cond_app/pages/agenda/visitas/visitas_bloc.dart';
import 'package:cond_app/utils/exports.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VisitasFormPage extends StatefulWidget {

  VisitasFormPage({Key? key}) : super(key: key);

  @override
  _VisitasFormPageState createState() => _VisitasFormPageState();
}

class _VisitasFormPageState extends State<VisitasFormPage> {
  final _formKey = GlobalKey<FormState>();

  Timestamp? timestampVisita;
  final _bloc = VisitasBloc();
  final _tVisitante = TextEditingController();
  final _tRGVisitante = TextEditingController();
  final f = DateFormat('dd/MM/yyyy - hh:mm');

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova visita"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            AppText(
              hint: "Nome do visitante",
              icon: Ionicons.person,
              controller: _tVisitante,
              validator: (s) => _validateName(s),
            ),
            const SizedBox(height: 8),
            AppText(
              hint: "RG do visitante",
              icon: Ionicons.document_text,
              validator: (s) => _validateDoc(s),
              controller: _tRGVisitante,
            ),
            const SizedBox(height: 8),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: DateTimePicker(
                  initialValue: '',
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  dateMask: 'dd/MM/yyyy',
                  use24HourFormat: true,
                  dateLabelText: 'Data',
                  icon: const Icon(Ionicons.calendar),
                  onChanged: (val) {
                    print(val);
                    timestampVisita = Timestamp.fromDate(DateTime.parse(val));
                  },
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ButtonWidget(
              btnText: "Confirmar",
              onClick: _onClickSalvar,
            ),
          ],
        ),
      ),
    );
  }

  _onClickSalvar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String nomeVisitante = _tVisitante.text;
    String docVisitante = _tRGVisitante.text;

    Visita v = Visita(dataVisita: timestampVisita, nomeVisitante: nomeVisitante, RGVisitante: docVisitante);

    ApiResponse visitaResponse;
      visitaResponse = await _bloc.addVisita(
          visita: v, uid: FirebaseAuth.instance.currentUser!.uid);

      if (visitaResponse.ok!) {
        alert(context, 'Visita agendada com sucesso!', callback: pop(context));
      } else {
        alert(context, visitaResponse.msg!);
      }
    }

  _validateName(String? text) {
    if (text == null) {
      return "Digite o nome do visitante";
    }
    return null;
  }

  _validateDoc(String? text) {
    if (text == null) {
      return "Digite o documento do visitante";
    }
    return null;
  }
}
