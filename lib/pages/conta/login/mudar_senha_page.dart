import 'package:cond_app/utils/exports.dart';

class MudarSenhaPage extends StatefulWidget {
  const MudarSenhaPage({Key? key}) : super(key: key);

  @override
  _MudarSenhaPageState createState() => _MudarSenhaPageState();
}

class _MudarSenhaPageState extends State<MudarSenhaPage> {
  User? user;

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trocar Senha"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo_name.png'),
          const Text(
            "Ao clicar no botão abaixo será enviado um link para o e-mail cadastrado no aplicativo para redefinir sua senha.",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
            textAlign: TextAlign.center,
            // maxLines: 3,
          ),
          const SizedBox(height: 32),
          ButtonWidget(
            btnText: "Redefinir senha",
            onClick: _sendPasswordReset,
          ),
        ],
      ),
    );
  }

  _sendPasswordReset() {
    if (user != null) {
      String email;
      email = user!.email!;
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then(
            (value) => alert(
          context,
          "Um link para redefinição de senha foi enviado para o e-mail: $email",
        ),
      )
          .onError((error, stackTrace) {
        alertCancel(
          context,
          "Não foi possível enviar o email para a redefinição de senha.\nPor favor, tente novamente!",
          callback: _sendPasswordReset,
        );
      });
    }
  }
}
