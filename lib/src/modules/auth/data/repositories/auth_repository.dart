import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hawihub/src/core/error/exception_manager.dart';
import 'package:hawihub/src/modules/auth/data/models/auth_player.dart';
import 'package:hawihub/src/modules/auth/data/models/user.dart';
import 'package:hawihub/src/modules/main/data/models/sport.dart';
import '../services/auth_services.dart';

class AuthRepository {
  final AuthService _service = AuthService();

  Future<Either<Exception, String>> loginPlayer(
      {required String email,
      required String password,
      required bool loginWithFBOrGG}) async {
    return await _service.loginOwner(
        email: email, password: password, loginWithFBOrGG: loginWithFBOrGG);
  }

  Future<Either<Exception, String>> loginWithGoogle() async {
    return await _service.loginWithGoogle();
  }

  Future<Either<Exception, String>> loginWithFacebook() async {
    return await _service.loginWithFacebook();
  }

  Future<Either<Exception, AuthPlayer?>> signupWithGoogle() async {
    return await _service.signupWithGoogle();
  }

  Future<Either<Exception, AuthPlayer?>> signupWithFacebook() async {
    return await _service.signupWithFacebook();
  }

  Future<Either<Exception, String>> registerPlayer({
    required AuthPlayer authPlayer,
  }) async {
    return _service.registerPlayer(
      authPlayer: authPlayer,
    );
  }

  Future<Either<Exception, String>> confirmEmail() async {
    return await _service.confirmEmail();
  }

  Future<Either<Exception, String>> verifyConfirmEmail(String code) async {
    return await _service.verifyConfirmEmail(code);
  }

  Future<String> resetPassword(String email) async {
    return _service.resetPassword(email);
  }

  Future<Either<Exception, List<Sport>>> getSports() async {
    return _service.getSports();
  }

  Future<Either<Exception, String>> changeProfileImage(
      File newProfileImage) async {
    return _service.changeProfileImage(newProfileImage);
  }

  Future<Either<Exception, String>> uploadNationalId(File nationalId) async {
    return _service.verificationNationalId(nationalId);
  }

  Future<Either<Exception, String>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    return _service.changePassword(
        oldPassword: oldPassword, newPassword: newPassword);
  }

  // Future<String> deleteProfileImage() async {
  //   return _service.deleteProfileImage();
  // }

  Future<Either<Exception, String>> verifyCode({
    required String email,
    required String code,
    required String password,
  }) async {
    return _service.verifyCode(email: email, code: code, password: password);
  }

  Future<Either<Exception, User>> getProfile(int id, String userType) async {
    return _service.getProfile(id, userType);
  }
}
