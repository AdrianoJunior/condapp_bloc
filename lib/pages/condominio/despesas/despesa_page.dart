import 'package:cond_app/pages/condominio/despesas/despesa.dart';
import 'package:cond_app/utils/exports.dart';
import 'package:intl/intl.dart';

class DespesaPage extends StatelessWidget {
  Despesa despesa;

  DespesaPage({Key? key, required this.despesa}) : super(key: key);

  final f = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Descrição", style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            ),
            Text(
              "${despesa.nome}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            const Text("Data",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              f.format(despesa.dataVencimento!.toDate()),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            const Text("Valor", style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            ),
            Text(
              "R\$ ${despesa.valor}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Confirmar",
                    style: TextStyle(
                      color: Color(0xff3DBF40),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Negar",
                    style: TextStyle(
                      color: Color(0xff8F1919),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]
            )
          ],
        ),
      ),
    );
  }
}
