import 'package:cond_app/utils/exports.dart';

class PerfilBloc extends SimpleBloc<bool> {
  Future<ApiResponse> updateProfile(
      Map<String, dynamic> map, String uid) async {
    add(true);

    ApiResponse response = await FirebaseService.saveUserData(map, uid);

    add(false);

    return response;
  }
}