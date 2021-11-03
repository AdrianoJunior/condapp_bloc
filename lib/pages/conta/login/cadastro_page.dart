import 'package:cond_app/utils/exports.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _tNome = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _bloc = LoginBloc();

  final _focusEmail = FocusNode();
  final _focusSenha = FocusNode();

  final _focusData = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _body(),
    );
  }

  _body() {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: <Widget>[
              HeaderContainer("Registre-se"),
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      AppText(
                        hint: "Nome",
                        icon: Icons.person,
                        inputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        validator: (s) => _validateNome(s),
                        controller: _tNome,
                        nextFocus: _focusEmail,
                      ),
                      AppText(
                        hint: "E-mail",
                        icon: Icons.email,
                        inputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: (s) => _validateLogin(s),
                        controller: _tLogin,
                        nextFocus: _focusSenha,
                        focusNode: _focusEmail,
                      ),
                      // _textInput(hint: "Phone Number", icon: Icons.call),
                      AppText(
                        hint: "Senha",
                        icon: Icons.vpn_key,
                        inputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        validator: (s) => _validateSenha(s),
                        controller: _tSenha,
                        focusNode: _focusSenha,
                        nextFocus: _focusData,
                        password: true,
                      ),
                      Expanded(
                        child: Center(
                          child: StreamBuilder<bool>(
                              stream: _bloc.stream,
                              initialData: false,
                              builder: (context, snapshot) {
                                return ButtonWidget(
                                  btnText: "REGISTRE-SE",
                                  onClick: _onClickCadastro,
                                  showProgress: snapshot.data!,
                                );
                              }),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          push(context, const LoginPage(), replace: true);
                        },
                        child: RichText(
                          text: TextSpan(children: [
                            const TextSpan(
                                text: "Já possui uma conta? ",
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: "Faça login",
                                style: TextStyle(color: Colors.blue[700],),),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onClickCadastro() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String email = _tLogin.text;
    String senha = _tSenha.text;
    String nome = _tNome.text;
    Usuario user = Usuario(
      email: email,
      nome: nome,
      senha: senha,
    );

    ApiResponse createResponse = await _bloc.create(user);
    if (createResponse.ok!) {
      ApiResponse loginResponse = await _bloc.login(user);
      if (loginResponse.ok!) {
        /*String docResponse = await FirebaseApi.createUser(user);

        if(docResponse != null && docResponse.isNotEmpty) {
          Usuario().save();
          push(context, UsersPage(), replace: true);
        } else {
          alert(context, "Não foi possível salvar os dados do usuário, tente novamente!", callback: () async {

          });
        }*/
        push(context, const DespesasPage(), replace: true);

      } else {
        alert(context,
            "Não foi possível fazer login, volte para a tela de login e tente novamente!",
            callback: () {
              push(context, const LoginPage(), replace: true);
            });
      }
    } else {
      alert(context, "Não foi possível criar sua conta, tente novamente");
    }
  }

  String? _validateLogin(text) {
    if (text.isEmpty) {
      return "Digite seu e-mail";
    }
    return null;
  }

  String? _validateSenha(text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }
    return null;
  }


  String? _validateNome(String text) {
    if (text.isEmpty) {
      return "Digite o seu nome";
    }
    return null;
  }
}