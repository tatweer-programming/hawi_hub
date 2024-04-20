import 'package:dartz/dartz.dart';
import 'package:hawihub/src/modules/auth/data/models/player.dart';
import 'package:hawihub/src/modules/auth/data/services/auth_services.dart';

import '../models/auth_player.dart';
import '../models/sport.dart';

class AuthRepository {
  final AuthService _service = AuthService();
  Future<String> loginPlayer(String email, String password) async {
    return await _service.loginPlayer(email, password);
  }

  Future<Either<String, bool>> loginWithGoogle() async {
    return await _service.loginWithGoogle();
  }

  Future<Either<String, bool>>loginWithFacebook() async {
    return await _service.loginWithFacebook();
  }

  Future<Either<String, AuthPlayer?>> signupWithGoogle() async {
    return await _service.signupWithGoogle();
  }

  Future<Either<String, AuthPlayer?>>  signupWithFacebook() async {
    return await _service.signupWithFacebook();
  }

  Future<String> registerPlayer({
    required AuthPlayer authPlayer,
  }) async {
    return _service.registerPlayer(authPlayer: authPlayer,);
  }

  Future<String> verifyCode(String email) async {
    return _service.verifyCode(email);
  }

  Future<String> changeProfileImage(String newProfileImage) async {
    return _service.changeProfileImage(newProfileImage);
  }

  Future<String> deleteProfileImage() async {
    return _service.deleteProfileImage();
  }

  Future<String> resetPassword({
    required String email,
    required String code,
    required String password,
  }) async {
    return _service.resetPassword(email: email, code: code, password: password);
  }

  Future<Either<String, List<Sport>>> getSports() async {
    return _service.getSports();
  }

  Future<Either<String, Player>> getProfile(int id) async {
    return _service.getProfile(id);
  }

// Future<Either<Exception, String>> updateProfilePic(
//     File newImage) async {
//   return await _service.uploadProfilePic(newImage);
// }
//
// Future updateImageInFireStore(String newImageUrl) async {
//   return await _service.updateImageInFireStore(newImageUrl);
// }
//
// Future deleteOldPic(String url) async {
//   return await _service.deleteOldPic(url);
// }
}
