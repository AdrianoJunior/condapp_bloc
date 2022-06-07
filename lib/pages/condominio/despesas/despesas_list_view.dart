import 'package:cond_app/pages/condominio/despesas/despesa.dart';
import 'package:cond_app/utils/exports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class DespesasListView extends StatelessWidget {
  var despesas;

  DespesasListView({Key? key, required this.despesas}) : super(key: key);

  final f = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: despesas != null ? despesas.size : 0,
      itemBuilder: (context, idx) {
        if (despesas == null ) {
          return const Center(
              child: Text("Nenhuma despesa pendente para os próximos dias"));
        }
        Despesa d = despesas.docs[idx].data();

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
              child: _buildMobile(d, asset),
            ),
          ),
        );
      },
    );
  }

  _buildMobile(Despesa d, String asset) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Image.asset(
            asset,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Column(
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
        ),
      ],
    );
  }

  _buildWeb(Despesa d, String asset) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            asset,
            width: 150,
          ),
        ),
        const SizedBox(width: 8),
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
    );
  }
}
