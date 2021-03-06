import 'package:cond_app/utils/exports.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();

  final _bloc = LoginBloc();

  final _focusSenha = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Login"),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AppText(
                      hint: "Email",
                      icon: Icons.email,
                      controller: _tLogin,
                      validator: (s) => _validateLogin(s),
                      keyboardType: TextInputType.emailAddress,
                      nextFocus: _focusSenha,
                      inputAction: TextInputAction.next,
                    ),
                    AppText(
                      hint: "Senha",
                      icon: Icons.vpn_key,
                      controller: _tSenha,
                      validator: (s) => _validateSenha(s),
                      keyboardType: TextInputType.text,
                      focusNode: _focusSenha,
                      inputAction: TextInputAction.done,
                      password: true,
                    ),
                    Expanded(
                      child: Center(
                        child: StreamBuilder<bool>(
                            stream: _bloc.stream,
                            initialData: false,
                            builder: (context, snapshot) {
                              return ButtonWidget(
                                btnText: "LOGIN",
                                onClick: _onClickLogin,
                                showProgress: snapshot.data!,
                              );
                            }),
                      ),
                    ),
                    InkWell(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "N??o possui uma conta? ",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "Registre-se",
                              style: TextStyle(
                                color: Colors.blue[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        push(context, const CadastroPage(), replace: true);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _onClickLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    ApiResponse userResponse =
        await _bloc.login(Usuario(email: login, senha: senha));
    print("\n\n\nRESULT >>>>>>> ${userResponse.ok}\n\n\n");

    if (userResponse.ok!) {
      Navigator.pushReplacementNamed(context, '/');
    } else {
      alert(context, userResponse.msg!);
    }
  }

  String? _validateSenha(String text) {
    if (text.isEmpty) {
      return "Por favor, digite a senha";
    } else if (text.length < 6) {
      return "A senha deve conter ao menos 6 caracteres";
    }
    return null;
  }

  String? _validateLogin(String text) {
    if (text.isEmpty) {
      return "Por favor, digite seu e-mail";
    } else if(!EmailValidator.validate(text)) {
      return "Por favor, digite um e-mail v??lido.";
    }
    return null;
  }
}
