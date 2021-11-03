import 'package:cond_app/shared/usuario.dart';
import 'package:cond_app/utils/exports.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ApiResponse<User>> login(Usuario usuario) async {
    try {
      // Usuario do Firebase
      final authResult = await _auth.signInWithEmailAndPassword(
          email: usuario.email!, password: usuario.senha!);
      final User? fUser = authResult.user;
      print("signed in ${authResult.user!.displayName}");

      // Resposta genérica

      if (fUser != null) {
        return ApiResponse.ok(
            result: fUser /*result: true, msg: "Login efetuado com sucesso"*/);
      } else {
        return ApiResponse.error(
            msg: "Não foi possível fazer o login, tente novamente!");
      }
    } on FirebaseAuthException catch (e) {
      print(" >>> CODE : ${e.code}\n>>> ERRO : $e");
      return ApiResponse.error(
          msg: "Não foi possível fazer o login, tente novamente!");
    }
  }

  Future<ApiResponse<Usuario>> create(Usuario usuario) async {
    try {
      // Usuario do Firebase
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: usuario.email!, password: usuario.senha!);
      final User? fUser = authResult.user;
      print("created user ${authResult.user!.displayName}");

      fUser!.updateDisplayName(usuario.nome);

      final user = Usuario();
      if (fUser != null) {
        return ApiResponse.ok(result: user);
      } else {
        return ApiResponse.error(
            msg: "Não foi possível criar sua conta, tente novamente!");
      }
    } on FirebaseAuthException catch (e) {
      print(" >>> CODE : ${e.code}\n>>> ERRO : $e");

      if (e.code == 'email-already-in-use') {
        return ApiResponse.error(
            msg: 'Já existe um usuário cadastrado com este e-mail.');
      } else {
        return ApiResponse.error(
            msg: "Não foi possível criar sua conta, tente novamente!");
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }


  /*static Future<ApiResponse<String>> uploadFirebaseStorage(File file,
      String uid) async {
    try {
      String fileName = path.basename(file.path);
      final storageRef = FirebaseStorage.instance.ref().child('users').child(
          uid).child(fileName);

      final StorageTaskSnapshot task = await storageRef
          .putFile(file)
          .onComplete;
      final String downloadUrl = await task.ref.getDownloadURL();

      return ApiResponse.ok(result: downloadUrl);
    } catch (e) {
      print("UPLOAD ERROR >>>>>> $e");
      return ApiResponse.error();
    }
  }*/

  static Future<ApiResponse<bool>> saveUserData(Map<String, dynamic> mapUser,
      String uid) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(uid).set(mapUser);
      return ApiResponse.ok();
    } catch (e) {
      print("ERRO FIRESTORE SAVE >>>>> $e");

      return ApiResponse.error();
    }
  }

}
