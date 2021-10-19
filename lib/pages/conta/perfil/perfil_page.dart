import 'dart:io';

import 'package:cond_app/utils/exports.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  File? _file;

  final _tName = TextEditingController();

  String? urlFoto;
  User? user;

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      _tName.text = user!.displayName ?? "";
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Center(
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
              ),
              const SizedBox(height: 32),
              TextInput(
                hint: "Nome",
                icon: Ionicons.md_person_circle_outline,
              ),
              const SizedBox(height: 8),
              TextInput(
                hint: "Endereço",
                icon: MaterialCommunityIcons.google_maps,
              ),
              const SizedBox(height: 8),
              TextInput(
                hint: "Nº da casa",
                icon: Ionicons.home,
              ),
              const SizedBox(height: 24),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ButtonWidget(
                  btnText: "Salvar",
                  onClick: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onClickFoto() {}
}
