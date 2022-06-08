import 'dart:io';

import 'package:cond_app/pages/conta/perfil/perfil_bloc.dart';
import 'package:cond_app/utils/exports.dart';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';

import 'package:path/path.dart' as path;

import 'package:cond_app/widgets/app_text.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {

  final _bloc = PerfilBloc();

  final _tName = TextEditingController();
  final _tEnd = TextEditingController();
  final _tNum = TextEditingController();
  final _tData = TextEditingController();
  final _tFone = TextEditingController();

  String? urlFoto;
  User? user;

  ImageSource imageSource = ImageSource.gallery;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var maskFormatter = MaskTextInputFormatter(
      mask: '(##) # ####-####', filter: {"#": RegExp(r'[0-9]')});

  final _formKey = GlobalKey<FormState>();

  Timestamp dataNascimento = Timestamp.fromDate(DateTime.now());

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _tName.text = user!.displayName ?? "";
      print(">>>>>>> UID: ${user!.uid} <<<<<<<");

      firestore.collection('users').doc(user!.uid).get().then((value) {
        if (value.data() != null) {
          final f = DateFormat('dd/MM/yyyy');
          Usuario usuario = Usuario.fromMap(value.data()!);

          _tName.text = usuario.nome ?? user!.displayName ?? "";
          _tEnd.text = usuario.endereco ?? "";
          _tNum.text = usuario.numeroCasa ?? "";
          _tData.text = f.format(usuario.dataNascimento!.toDate());
          _tFone.text = usuario.telefone ?? "";
          dataNascimento = usuario.dataNascimento!;

          print(">>>>>>>>>>>>>>>>>>>>>> USUÁRIO <<<<<<<<<<<<<<<<<<<<<<<");
          print(usuario.id);
          print(usuario.nome);
          print(usuario.dataNascimento!.toDate());
          print(usuario.endereco);
          print(usuario.numeroCasa);
          print(usuario.telefone);
          print(">>>>>>>>>>>>>>>>>>>>>> USUÁRIO <<<<<<<<<<<<<<<<<<<<<<<");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                /*Center(
                  child: InkWell(
                    onTap: _onClickFoto,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      fit: StackFit.loose,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: _file != null
                              ? Image.file(
                                  _file!,
                                  height: 125,
                                  width: 125,
                                  fit: BoxFit.cover,
                                )
                              : urlFoto != null
                                  ? CachedNetworkImage(
                                      width: 125,
                                      height: 125,
                                      imageUrl: urlFoto!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Image.asset(
                                          'assets/images/default_image.png',
                                          height: 125,
                                          width: 125,
                                          fit: BoxFit.cover))
                                  : Image.asset(
                                      'assets/images/default_image.png',
                                      height: 125,
                                      width: 125,
                                      fit: BoxFit.cover,
                                    ),
                        ),
                        Positioned(
                          right: -3.9,
                          bottom: -3.9,
                          child: FloatingActionButton(
                            mini: true,
                            onPressed: _onClickFoto,
                            child: const Center(
                              child: Icon(
                                Icons.add_a_photo_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),*/
                // const SizedBox(height: 32),
                AppText(
                  hint: "Nome",
                  icon: Ionicons.md_person_circle_outline,
                  controller: _tName,
                  validator: (s) => _validateNome(s),
                ),
                const SizedBox(height: 8),
                AppText(
                  hint: "Endereço",
                  icon: MaterialCommunityIcons.google_maps,
                  controller: _tEnd,
                  validator: (s) => _validateEndereco(s),
                ),
                const SizedBox(height: 8),
                AppText(
                  hint: "Nº da casa",
                  icon: Ionicons.home,
                  controller: _tNum,
                  validator: (s) => _validateNum(s),
                ),
                const SizedBox(height: 8),
                /*AppText(
                  hint: "Data de Nascimento",
                  icon: Ionicons.calendar,
                  controller: _tData,
                ),*/

                const SizedBox(height: 16),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: DateTimePicker(
                    initialValue: dataNascimento.toDate().toString() ?? '',
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2100),
                    dateMask: 'dd/MM/yyyy',
                    use24HourFormat: true,
                    dateLabelText: 'Data',
                    icon: const Icon(Ionicons.calendar),
                    onChanged: (val) {
                      print(val);
                      dataNascimento = Timestamp.fromDate(DateTime.parse(val));
                    },
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 8),
                /*AppText(
                  hint: "Telefone",
                  icon: Ionicons.md_phone_portrait_sharp,
                  controller: _tFone,
                ),*/
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: _tFone,
                    validator: (s) => _validateFone(s),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [maskFormatter],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Telefone",
                      prefixIcon: Icon(Ionicons.md_phone_portrait_sharp),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<bool>(
                    stream: _bloc.stream,
                    initialData: false,
                    builder: (context, snapshot) {
                      return ButtonWidget(
                        btnText: "Salvar",
                        onClick: _onClickUpdate,
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateFone(String? text) {
    if (text!.isEmpty) {
      return "Digite seu telefone";
    }
    return null;
  }

  _validateNome(String? text) {
    if (text!.isEmpty) {
      return "Digite seu nome";
    }
    return null;
  }

  _validateNum(String? text) {
    if (text!.isEmpty) {
      return "Digite o número da sua casa";
    }
    return null;
  }

  _validateEndereco(String? text) {
    if (text!.isEmpty) {
      return "Digite o endereço da sua casa";
    }
    return null;
  }

  _onClickUpdate() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    User user = FirebaseAuth.instance.currentUser!;

    Usuario usuario = Usuario(
      dataNascimento: dataNascimento,
      email: user.email,
      id: user.uid,
      nome: _tName.text,
      endereco: _tEnd.text,
      numeroCasa: _tNum.text,
      telefone: _tFone.text,
    );

    ApiResponse updateResponse = await _bloc.updateProfile(usuario.toMap(), user.uid);

    if(updateResponse.ok!) {
      alert(context, "Dados atualizados com sucesso!", callback: () {
        Navigator.pushReplacementNamed(context, '/');
      });
    } else {
      alertCancel(context, "Não foi possível atualizar os dados, tente novamente!", callback: () {
        _onClickUpdate();
      });
    }


  }
}
