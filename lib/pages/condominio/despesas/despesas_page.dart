import 'package:cond_app/utils/exports.dart';
import 'package:intl/intl.dart';

import 'despesa.dart';

class DespesasPage extends StatefulWidget {
  const DespesasPage({Key? key}) : super(key: key);

  @override
  _DespesasPageState createState() => _DespesasPageState();
}

class _DespesasPageState extends State<DespesasPage> {
  final f = DateFormat('dd/MM/yyyy');

  List<Despesa> despesas = [
    /*Despesa(
      nome: "Campo de futebol",
      valor: 25.00,
      dataVencimento: DateTime(2022, 04, 05),
    ),
    Despesa(
      nome: "Salão de festas",
      valor: 75.00,
      dataVencimento: DateTime(2022, 04, 20),
    ),
    Despesa(
      nome: "Quiosque/churrasqueira",
      valor: 50.00,
      dataVencimento: DateTime(2022, 04, 18),
    ),*/
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesas"),
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: despesas.length,
        itemBuilder: (context, idx) {
          Despesa d = despesas[idx];
          String? asset;

          if(d.nome == 'Quiosque/churrasqueira') {
            asset = 'assets/images/churrasqueira.jpg';
          } else if (d.nome == "Salão de festas") {
            asset = 'assets/images/salao_festa.jpeg';
          } else {
            asset = 'assets/images/futebol.jpg';
          }
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        asset,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          d.nome!,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Valor: R\$ ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              TextSpan(
                                text: d.valor!.toStringAsFixed(2),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Vencimento: ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              TextSpan(
                                text: f.format(d.dataVencimento!.toDate()),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
