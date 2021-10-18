import 'dart:async';

import 'package:cond_app/utils/exports.dart';

class LoginBloc extends SimpleBloc<bool> {
  final StreamController<bool> _streamController = StreamController<bool>();

  get stream => _streamController.stream;

  Future<ApiResponse<User>> login(Usuario usuario) async {
    _streamController.add(true);

    ApiResponse<User> response = await FirebaseService().login(usuario);

    _streamController.add(false);

    return response;
  }

  Future<ApiResponse<Usuario>> create(Usuario user) async {
    _streamController.add(true);

    ApiResponse<Usuario> response = await FirebaseService().create(user);

    _streamController.add(false);

    return response;
  }

  @override
  void dispose() {
    _streamController.close();
  }
}