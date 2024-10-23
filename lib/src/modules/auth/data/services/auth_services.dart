import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hawihub/src/core/error/exception_manager.dart';
import 'package:hawihub/src/modules/auth/data/models/auth_player.dart';
import 'package:hawihub/src/modules/auth/data/models/owner.dart';
import 'package:hawihub/src/modules/auth/data/models/player.dart';
import 'package:hawihub/src/modules/auth/data/models/user.dart';
import 'package:hawihub/src/modules/main/data/models/sport.dart';
import 'package:hawihub/src/modules/places/data/models/feedback.dart';

import '../../../../core/apis/dio_helper.dart';
import '../../../../core/apis/end_points.dart';
import '../../../../core/local/shared_prefrences.dart';
import '../../../../core/utils/constance_manager.dart';

class AuthService {
  Future<Either<Exception, String>> register({
    required AuthPlayer authPlayer,
  }) async {
    try {
      Response response = await DioHelper.postData(
        data: authPlayer.toJson(),
        path: EndPoints.register,
      );
      ConstantsManager.userId = response.data['id'];
      return Right(response.data['message']);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, String>> confirmEmail() async {
    try {
      Response response = await DioHelper.postData(
        path: EndPoints.confirmEmail + ConstantsManager.userId.toString(),
      );
      return Right(response.data.toString());
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, String>> verifyConfirmEmail(String code) async {
    try {
      Response response = await DioHelper.postData(
        data: {"confirmEmailCode": code},
        path: EndPoints.verifyConfirmEmail + ConstantsManager.userId.toString(),
      );
      await CacheHelper.saveData(key: 'userId', value: ConstantsManager.userId);
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, String>> login(
      {required String email,
      required String password,
      required bool loginWithFBOrGG}) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          "email": email,
          "password": password,
          "loginWithFBOrGG": loginWithFBOrGG
        },
        path: EndPoints.login,
      );
      if (response.data != "Email is not exists.") {
        ConstantsManager.userId = response.data['id'];
        await CacheHelper.saveData(key: 'userId', value: response.data['id']);
        return Right(response.data['message']);
      }
      return Left(response.data);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, AuthPlayer?>> signupWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: <String>[
          'email',
        ],
      );
      await googleSignIn.signOut();
      var googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        AuthPlayer authPlayer = AuthPlayer(
          email: googleUser.email,
          userName: googleUser.displayName!,
          profilePictureUrl: googleUser.photoUrl,
          password: '',
          birthDate: '',
          gender: 0,
        );
        return Right(authPlayer);
      }
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, String>> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: <String>[
          'email',
        ],
      );
      await googleSignIn.signOut();
      var googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final message = await login(
          email: googleUser.email,
          password: "string",
          loginWithFBOrGG: true,
        );
        message.fold(
          (l) {
            return Left(l);
          },
          (r) {
            return Right(message);
          },
        );
      }
      return const Right("Something went wrong");
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, AuthPlayer?>> signupWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      Map<String, dynamic>? userData;
      if (result.status == LoginStatus.success) {
        userData = await FacebookAuth.instance.getUserData();
      }
      if (result.status == LoginStatus.success && userData != null) {
        AuthPlayer authPlayer = AuthPlayer(
          email: userData['email'],
          userName: userData['name'],
          profilePictureUrl: userData['picture']['data']['url']!,
          birthDate: '',
          password: '',
          gender: 0,
        );
        return Right(authPlayer);
      }
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, String>> loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();

        final message = await login(
          email: userData['email'],
          password: "string",
          loginWithFBOrGG: true,
        );
        message.fold(
          (l) {
            return Left(l);
          },
          (r) {
            return Right(message);
          },
        );
      }
      return const Right("Something went wrong");
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          'email': email,
        },
        path: EndPoints.resetPass,
      );
      return response.data.toString();
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<Either<Exception, String>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
        path: "${EndPoints.changePassword}/${ConstantsManager.userId}",
      );
      return Right(response.data['message']);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  /// TODO
  Future<Either<Exception, String>> changeProfileImage(
      File newProfileImage) async {
    try {
      await DioHelper.putDataFormData(
        token: ConstantsManager.userId.toString(),
        data: FormData.fromMap({'ProfilePicture': newProfileImage}),
        path: EndPoints.changeImageProfile,
      );
      return const Right("Profile image updated successfully");
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, String>> verificationNationalId(
      File nationalId) async {
    try {
      String nationalIdUrl = await _uploadNationalId(nationalId);
      Response response = await DioHelper.postData(
          path: "${EndPoints.verification}/${ConstantsManager.userId}",
          data: {"proofOfIdentityUrl": nationalIdUrl});
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<String> _uploadNationalId(File nationalId) async {
    try {
      Response response = await DioHelper.postFormData(
        EndPoints.uploadProof,
        FormData.fromMap(
            {'ProofOfIdentity': MultipartFile.fromFileSync(nationalId.path)}),
      );
      return response.data['proofOfIdentityUrl'];
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<Either<Exception, String>> verifyCode({
    required String email,
    required String code,
    required String password,
  }) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          "resetCode": code,
          "email": email,
          "newPassword": password,
        },
        path: EndPoints.verifyResetCode,
      );
      await login(
          email: email, password: password, loginWithFBOrGG: false);
      return Right(response.data);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, User>> getProfile(int id, String userType) async {
    try {
      Response response = await DioHelper.getData(
        path: "/$userType/$id",
      );
      if (userType == "Player") {
        Player player = Player.fromJson(response.data);
        var res = await getFeedBacks(id, false);
        res.fold((l) {}, (r) => player.feedbacks = r);
        if (ConstantsManager.userId == id) {
          ConstantsManager.appUser = player;
        }
        return Right(player);
      } else {
        Owner owner = Owner.fromJson(response.data);
        var res = await getFeedBacks(id, true);
        res.fold((l) {}, (r) => owner.feedbacks = r);
        return Right(owner);
      }
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, List<Sport>>> getSports() async {
    try {
      Response response = await DioHelper.getData(
        path: EndPoints.getSports,
      );
      List<Sport> sports = [];
      for (var category in response.data) {
        sports.add(Sport.fromJson(category));
      }
      return Right(sports);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, List<AppFeedBack>>> getFeedBacks(
      int id, bool isOwner) async {
    try {
      Response response = await DioHelper.getData(
        path:
            "${isOwner ? EndPoints.getOwnerFeedbacks : EndPoints.getPlayerFeedbacks}$id",
      );
      List<AppFeedBack> feedBacks = [];
      for (var category in response.data["reviews"]) {
        feedBacks.add(AppFeedBack.fromJson(category));
      }
      return Right(feedBacks);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
