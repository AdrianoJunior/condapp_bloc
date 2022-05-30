import 'package:cond_app/pages/condominio/despesas/despesa.dart';
import 'package:cond_app/utils/exports.dart';
import 'package:intl/intl.dart';

import 'despesa_page.dart';

class DespesasListView extends StatelessWidget {
  var despesas;

  DespesasListView({Key? key, required this.despesas}) : super(key: key);

  final f = DateFormat('dd/MM/yyyy - hh:mm');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: despesas != null ? despesas.length : 0,
      itemBuilder: (context, idx) {
        if (despesas == null ) {
          return const Center(
              child: Text("Nenhuma despesa pendente para os próximos dias"));
        }
        Despesa d = despesas.docs[idx].data();

        return Padding(
          padding: const EdgeInsets.only(top: 4),
          child: InkWell(
            onTap: () {
              push(context, DespesaPage(despesa: d));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 8,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Descrição",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${d.nome}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Vencimento",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      f.format(d.dataVencimento!.toDate()),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Valor",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "R\$ ${d.valor!}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    /*ButtonBarTheme(
                      data: ButtonBarTheme.of(context),
                      child: ButtonBar(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Confirmar",
                              style: TextStyle(
                                color: Color(0xff3DBF40),
                                fontSize: 16,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Negar",
                              style: TextStyle(
                                color: Color(0xff8F1919),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )*/
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
