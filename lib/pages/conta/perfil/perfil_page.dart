import 'dart:io';

import 'package:cond_app/utils/exports.dart';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:path/path.dart' as path;

import 'package:cond_app/widgets/app_text.dart';

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

  ImageSource imageSource = ImageSource.gallery;

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      _tName.text = user!.displayName ?? "";
      print(">>>>>>> UID: ${user!.uid} <<<<<<<");
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
              AppText(
                hint: "Nome",
                icon: Ionicons.md_person_circle_outline,
              ),
              const SizedBox(height: 8),
              AppText(
                hint: "Endereço",
                icon: MaterialCommunityIcons.google_maps,
              ),
              const SizedBox(height: 8),
              AppText(
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

  Future<void> _onClickFoto() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Câmera'),
            onTap: () {
              Navigator.pop(context);
              imageSource = ImageSource.camera;
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_album),
            title: const Text('Galeria'),
            onTap: () {
              Navigator.pop(context);
              imageSource = ImageSource.gallery;
            },
          ),
        ],
      ),
    );

    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker.pickImage(source: imageSource);

    if (pickedFile != null) {
      File? file = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          androidUiSettings: const AndroidUiSettings(
            toolbarTitle: "",
          ));

      if (file != null) {
        setState(() {
          this._file = file;
        });
        uploadFile(file);
      }
    }
  }

  /// The user selects a file, and the task is added to the list.
  Future<String?> uploadFile(File? file) async {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Nenhum arquivo selecionado'),
      ));
      return null;
    }

    firebase_storage.UploadTask uploadTask;

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users')
        .child('/${user!.uid}/${user!.uid}');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);
    }
    print("DOWNLOAD URL >>>>> ${uploadTask.snapshot.ref.getDownloadURL()}");
    return uploadTask.snapshot.ref.getDownloadURL();
  }
}
