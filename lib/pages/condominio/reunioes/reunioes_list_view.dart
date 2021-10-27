import 'package:cond_app/utils/exports.dart';
import 'package:intl/intl.dart';

class ReunioesListView extends StatelessWidget {
  var reunioes;

  ReunioesListView({required this.reunioes});

  final f = DateFormat('dd/MM/yyyy - hh:mm');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reunioes != null ? reunioes.size : 0,
      itemBuilder: (context, idx) {
        if (reunioes == null) {
          return const Center(
              child: Text("Nenhuma reunião marcada para os próximos dias"));
        }
        Reuniao r = reunioes.docs[idx].data();

        return Padding(
          padding: const EdgeInsets.only(top: 4),
          child: InkWell(
            onTap: () {
              push(context, ReuniaoPage(reuniao: r));
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
                      "Reunião de moradores",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      f.format(r.data!.toDate()),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Descrição",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      r.desc!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    ButtonBarTheme(
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
                    )
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
