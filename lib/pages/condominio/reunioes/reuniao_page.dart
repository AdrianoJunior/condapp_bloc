import 'package:cond_app/utils/exports.dart';
import 'package:intl/intl.dart';

class ReuniaoPage extends StatelessWidget {
  Reuniao reuniao;

  ReuniaoPage({Key? key, required this.reuniao}) : super(key: key);

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
            const Text("Data",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              f.format(reuniao.data!.toDate()),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            const Text("Descrição", style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            ),
            Text(
              "${reuniao.desc}",
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
