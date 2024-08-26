import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/local/shared_prefrences.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/modules/auth/data/models/auth_player.dart';
import 'package:hawihub/src/modules/auth/data/models/user.dart';
import 'package:hawihub/src/modules/auth/data/repositories/auth_repository.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/data/models/sport.dart';
import 'package:hawihub/src/modules/main/data/services/notification_services.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static AuthBloc instance = AuthBloc(AuthInitial());

  static AuthBloc get(BuildContext context) =>
      BlocProvider.of<AuthBloc>(context);

  final AuthRepository _repository = AuthRepository();

  // time
  Timer? timeToResendCodeTimer;

  AuthBloc(AuthState state) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is RegisterPlayerEvent) {
        emit(RegisterLoadingState());
        var result =
            await _repository.registerPlayer(authPlayer: event.authPlayer);
        result.fold((l) => emit(RegisterErrorState(l)), (r) async {
          emit(RegisterSuccessState(value: r));
          await NotificationServices().subscribeToTopic();
        });
      } else if (event is ConfirmEmailEvent) {
        add(StartResendCodeTimerEvent(120));
        emit(ConfirmEmailLoadingState());
        var result = await _repository.confirmEmail();
        result.fold((l) => emit(ConfirmEmailErrorState(l)), (r) async {
          emit(ConfirmEmailSuccessState(value: r));
        });
      } else if (event is VerifyConfirmEmailEvent) {
        emit(VerifyConfirmEmailLoadingState());
        var result = await _repository.verifyConfirmEmail(event.code);
        result.fold((l) => emit(VerifyConfirmEmailErrorState(l)), (r) async {
          emit(VerifyConfirmEmailSuccessState(value: r));
          await NotificationServices().subscribeToTopic();
        });
      } else if (event is LoginPlayerEvent) {
        emit(LoginLoadingState());
        await _repository
            .loginPlayer(
                email: event.email,
                password: event.password,
                loginWithFBOrGG: false)
            .then((value) async{
          if (value == "Account LogedIn Successfully") {
            await NotificationServices().subscribeToTopic();
            emit(LoginSuccessState(value));
          } else {
            emit(LoginErrorState(value));
          }
        });
      } else if (event is VerifyCodeEvent) {
        emit(VerifyCodeLoadingState());
        var result = await _repository.verifyCode(
          code: event.code,
          email: event.email,
          password: event.password,
        );
        result.fold((l) => emit(VerifyCodeErrorState(l)),
            (r) => emit(VerifyCodeSuccessState(value: r)));
      } else if (event is ResetPasswordEvent) {
        add(StartResendCodeTimerEvent(120));
        emit(ResetPasswordLoadingState());
        await _repository.resetPassword(event.email).then((value) {
          if (value == "Reset code sent successfully to ${event.email}.") {
            String msg =
                "${S.of(event.context).resetCodeSentSuccessfully} ${event.email}.";
            emit(ResetPasswordSuccessState(msg));
          } else {
            emit(ResetPasswordErrorState(value));
          }
        });
      } else if (event is LoginWithGoogleEvent) {
        emit(LoginLoadingState());
        var result = await _repository.loginWithGoogle();
        result.fold((l) {
          emit(LoginErrorState(l));
        }, (r) {
          if (r == "Account LogedIn Successfully") {
            emit(LoginSuccessState(r));
          } else {
            emit(LoginErrorState(r));
          }
        });
      } else if (event is LoginWithFacebookEvent) {
        emit(LoginLoadingState());
        var result = await _repository.loginWithFacebook();
        result.fold((l) {
          emit(LoginErrorState(l));
        }, (r) {
          if (r == "Account LogedIn Successfully") {
            emit(LoginSuccessState(r));
          } else {
            emit(LoginErrorState(r));
          }
        });
      } else if (event is SignupWithGoogleEvent) {
        emit(SignupWithGoogleLoadingState());
        var result = await _repository.signupWithGoogle();
        result.fold((l) {
          emit(SignupWithGoogleErrorState(l));
        }, (r) {
          if (r != null) {
            emit(SignupWithGoogleSuccessState(r));
          } else {
            emit(SignupWithGoogleErrorState("Something went wrong"));
          }
        });
      } else if (event is SignupWithFacebookEvent) {
        emit(SignupWithFacebookLoadingState());
        var result = await _repository.signupWithFacebook();
        result.fold((l) {
          emit(SignupWithFacebookErrorState(l));
        }, (r) {
          if (r != null) {
            emit(SignupWithFacebookSuccessState(r));
          } else {
            emit(SignupWithFacebookErrorState("Something went wrong"));
          }
        });
      } else if (event is LogoutEvent) {
        emit(LogoutLoadingState());
        _clearUserData();
        emit(LogoutSuccessState());
      } else if (event is ChangePasswordEvent) {
        var result = await _repository.changePassword(
          oldPassword: event.oldPassword,
          newPassword: event.newPassword,
        );
        result.fold((l) {
          ChangePasswordErrorState(l);
        }, (r) {
          emit(ChangePasswordSuccessState(r));
        });
      } else if (event is DeleteImageEvent) {
        emit(DeleteImageState());
      } else if (event is UploadNationalIdEvent) {
        emit(UploadNationalIdLoadingState());
        var res = await _repository.uploadNationalId(event.nationalId);
        res.fold((l) {
          emit(UploadNationalIdErrorState(l));
        }, (r) {
          emit(UploadNationalIdSuccessState(r));
        });
      } else if (event is UpdateProfilePictureEvent) {
        add(AddImageEvent());
        if (state is AddImageSuccessState) {
          await _repository.changeProfileImage(event.profileImage);
        }
      } else if (event is GetProfileEvent) {
        emit(GetProfileLoadingState());
        var res = await _repository.getProfile(event.id, event.userType);
        res.fold((l) {
          emit(GetProfileErrorState(l));
        }, (r) {
          emit(GetProfileSuccessState(r));
        });
      } else if (event is AcceptConfirmTermsEvent) {
        if (event.accept) {
          emit(AcceptConfirmTermsState(false));
        } else {
          emit(AcceptConfirmTermsState(true));
        }
      } else if (event is KeepMeLoggedInEvent) {
        if (event.keepMeLoggedIn) {
          emit(KeepMeLoggedInState(false));
        } else {
          emit(KeepMeLoggedInState(true));
        }
      } else if (event is ChangePasswordVisibilityEvent) {
        if (event.visible) {
          emit(ChangePasswordVisibilityState(false));
        } else {
          emit(ChangePasswordVisibilityState(true));
        }
      } else if (event is StartResendCodeTimerEvent) {
        timeToResendCodeTimer?.cancel();
        _startResendCodeTimer(event.timeToResendCode);
      }else if (event is ShowDialogEvent) {
        emit(ShowBirthDateDialogState());
      } else if (event is ResetCodeTimerEvent) {
        timeToResendCodeTimer?.cancel();
        emit(ResetCodeTimerState(time: 0));
      } else if (event is PlaySoundEvent) {
        final audioPlayer = AudioPlayer();
        await audioPlayer.play(AssetSource(event.sound));
        emit(PlaySoundState());
      } else if (event is SelectSportEvent) {
        List<Sport> selectedSports = event.sports;
        if (event.sports.contains(event.sport)) {
          selectedSports.remove(event.sport);
          emit(SelectSportState(sports: selectedSports));
        } else {
          selectedSports.add(event.sport);
          emit(SelectSportState(sports: selectedSports));
        }
      } else if (event is GetSportsEvent) {
        emit(GetSportsLoadingState());
        var res = await _repository.getSports();
        res.fold((l) {
          emit(GetSportsErrorState(l));
        }, (r) {
          emit(GetSportsSuccessState(r));
        });
      } else if (event is AddImageEvent) {
        await _captureAndSaveGalleryImage().then((imagePicked) {
          emit(AddImageSuccessState(imagePicked: imagePicked!));
        });
      }
    });
  }

  void _startResendCodeTimer(int timeToResendCode) {
    timeToResendCode = 120;
    timeToResendCodeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeToResendCode > 0) {
        timeToResendCode--;
        emit(ChangeTimeToResendCodeState(time: timeToResendCode));
      } else {
        timeToResendCodeTimer?.cancel();
        timeToResendCode = 0;
        emit(ChangeTimeToResendCodeState(time: 0));
      }
    });
  }

  Future<File?> _captureAndSaveGalleryImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png','jpeg','jpg','webp','tiff'],
      allowMultiple: false,
    );
    if (result != null) {
      final image = File(result.files.single.path!);
      return image;
    } else {
      return null;
    }
  }

  Future _clearUserData() async {
    ConstantsManager.userId = null;
    ConstantsManager.appUser = null;
    ConstantsManager.connectionId = null;
    ConstantsManager.connectionToken = null;
    MainCubit.get().currentIndex = 0;
    await NotificationServices().unsubscribeFromTopic();
    await CacheHelper.removeData(key: "userId");
  }
}
