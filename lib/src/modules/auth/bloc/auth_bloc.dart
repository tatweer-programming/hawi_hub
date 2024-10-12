import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/error/exception_manager.dart';
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
  final AuthRepository _repository = AuthRepository();

  // time
  Timer? timeToResendCodeTimer;

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is RegisterPlayerEvent) {
        await _registerPlayer(event, emit);
      } else if (event is ConfirmEmailEvent) {
        await _confirmEmail(event, emit);
      } else if (event is VerifyConfirmEmailEvent) {
        await _verifyConfirmEmail(event, emit);
      } else if (event is LoginPlayerEvent) {
        await _loginPlayer(event, emit);
      } else if (event is VerifyCodeEvent) {
        await _verifyCode(event, emit);
      } else if (event is ResetPasswordEvent) {
        await _resetPassword(event, emit);
      } else if (event is LoginWithGoogleEvent) {
        await _loginWithGoogle(event, emit);
      } else if (event is LoginWithFacebookEvent) {
        await _loginWithFacebook(event, emit);
      } else if (event is SignupWithGoogleEvent) {
        await _signupWithGoogle(event, emit);
      } else if (event is SignupWithFacebookEvent) {
        await _signupWithFacebook(event, emit);
      } else if (event is LogoutEvent) {
        await _logout(event, emit);
      } else if (event is ChangePasswordEvent) {
        await _changePassword(event, emit);
      } else if (event is DeleteImageEvent) {
        emit(DeleteImageState());
      } else if (event is UploadNationalIdEvent) {
        await _uploadNationalId(event, emit);
      } else if (event is UpdateProfilePictureEvent) {
        await _updateProfilePicture(event, emit);
      } else if (event is GetProfileEvent) {
        await _getProfile(event, emit);
      } else if (event is AcceptConfirmTermsEvent) {
        _acceptConfirmTerms(event, emit);
      } else if (event is KeepMeLoggedInEvent) {
        _keepMeLoggedIn(event, emit);
      } else if (event is ChangePasswordVisibilityEvent) {
        _changePassVisibility(event, emit);
      } else if (event is StartResendCodeTimerEvent) {
        await _startResendCodeTimer(event, emit);
      } else if (event is ShowDialogEvent) {
        emit(ShowBirthDateDialogState());
      } else if (event is ResetCodeTimerEvent) {
        _resetCodeTimer(event, emit);
      } else if (event is PlaySoundEvent) {
        await _playSound(event, emit);
      } else if (event is SelectSportEvent) {
        _selectSport(event, emit);
      } else if (event is GetSportsEvent) {
        await _getSports(event, emit);
      } else if (event is AddImageEvent) {
        await _addImage(event, emit);
      } else if (event is DetermineGenderEvent) {
        _determineGender(event, emit);
      }
    });
  }

  Future<void> _startResendCodeTimer(
    StartResendCodeTimerEvent event,
    Emitter<AuthState> emit,
  ) async {
    timeToResendCodeTimer?.cancel(); // Cancel any previous timers

    int timeToResendCode = event.timeToResendCode;
    timeToResendCode = 120; // Set the timer value

    final completer =
        Completer<void>(); // Use a completer to keep the function alive

    timeToResendCodeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (emit.isDone) {
        timer.cancel();
        completer.complete(); // Completes the function if emitter is done
        return;
      }

      if (timeToResendCode > 0) {
        timeToResendCode--;
        emit(ChangeTimeToResendCodeState(time: timeToResendCode));
      } else {
        timer.cancel();
        emit(ChangeTimeToResendCodeState(time: 0));
        completer.complete(); // Complete when countdown is over
      }
    });

    await completer.future; // Wait for the completer to complete
  }

  Future<File?> _captureAndSaveGalleryImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpeg', 'jpg', 'webp', 'tiff'],
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

  Future<void> _registerPlayer(
      RegisterPlayerEvent event, Emitter<AuthState> emit) async {
    emit(RegisterLoadingState());
    var result = await _repository.registerPlayer(authPlayer: event.authPlayer);
    result.fold((l) => emit(RegisterErrorState(l)), (r) async {
      emit(RegisterSuccessState(value: r));
      await NotificationServices().subscribeToTopic();
    });
  }

  Future<void> _confirmEmail(
      ConfirmEmailEvent event, Emitter<AuthState> emit) async {
    add(StartResendCodeTimerEvent(120));
    emit(ConfirmEmailLoadingState());
    var result = await _repository.confirmEmail();
    result.fold((l) => emit(ConfirmEmailErrorState(l)), (r) async {
      emit(ConfirmEmailSuccessState(value: r));
    });
  }

  Future<void> _verifyConfirmEmail(
      VerifyConfirmEmailEvent event, Emitter<AuthState> emit) async {
    emit(VerifyConfirmEmailLoadingState());
    var result = await _repository.verifyConfirmEmail(event.code);
    result.fold((l) => emit(VerifyConfirmEmailErrorState(l)), (r) async {
      emit(VerifyConfirmEmailSuccessState(value: r));
      await NotificationServices().subscribeToTopic();
    });
  }

  Future<void> _loginPlayer(
      LoginPlayerEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());
    final res = await _repository.loginPlayer(
        email: event.email, password: event.password, loginWithFBOrGG: false);
    res.fold(
      (l) {
        emit(LoginErrorState(l));
      },
      (r) async {
        // if (r == "Account LogedIn Successfully") {
        emit(LoginSuccessState(r));
        await NotificationServices().subscribeToTopic();
        // } else {
        //   emit(LoginErrorState(Exception()));
        // }
      },
    );
  }

  Future<void> _verifyCode(
      VerifyCodeEvent event, Emitter<AuthState> emit) async {
    emit(VerifyCodeLoadingState());
    var result = await _repository.verifyCode(
      code: event.code,
      email: event.email,
      password: event.password,
    );
    result.fold((l) => emit(VerifyCodeErrorState(l)),
        (r) => emit(VerifyCodeSuccessState(value: r)));
  }

  Future<void> _resetPassword(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    add(StartResendCodeTimerEvent(120));
    emit(ResetPasswordLoadingState());
    await _repository.resetPassword(event.email).whenComplete(
      () {
        // if (value == "Reset code sent successfully to ${event.email}.") {
        String msg =
            "${S.of(event.context).resetCodeSentSuccessfully} ${event.email}.";
        emit(ResetPasswordSuccessState(msg));
        // } else {
        //   emit(ResetPasswordErrorState(Exception()));
        // }
      },
    );
  }

  Future<void> _loginWithGoogle(
      LoginWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());
    var result = await _repository.loginWithGoogle();
    result.fold((l) {
      emit(LoginErrorState(l));
    }, (r) {
      // if (r == "Account LogedIn Successfully") {
      emit(LoginSuccessState(r));
      // } else {
      //   emit(LoginErrorState(Exception()));
      // }
    });
  }

  Future<void> _loginWithFacebook(
      LoginWithFacebookEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());
    var result = await _repository.loginWithFacebook();
    result.fold((l) {
      emit(LoginErrorState(l));
    }, (r) {
      // if (r == "Account LogedIn Successfully") {
      emit(LoginSuccessState(r));
      // } else {
      //   emit(LoginErrorState(Exception()));
      // }
    });
  }

  Future<void> _signupWithGoogle(
      SignupWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(SignupWithGoogleLoadingState());
    var result = await _repository.signupWithGoogle();
    result.fold((l) {
      emit(SignupWithGoogleErrorState(l));
    }, (r) {
      if (r != null) {
        emit(SignupWithGoogleSuccessState(r));
      } else {
        emit(SignupWithGoogleErrorState(Exception()));
      }
    });
  }

  Future<void> _signupWithFacebook(
      SignupWithFacebookEvent event, Emitter<AuthState> emit) async {
    emit(SignupWithFacebookLoadingState());
    var result = await _repository.signupWithFacebook();
    result.fold((l) {
      emit(SignupWithFacebookErrorState(l));
    }, (r) {
      // if (r != null) {
      emit(SignupWithFacebookSuccessState(r!));
      // } else {
      //   emit(SignupWithFacebookErrorState(Exception()));
      // }
    });
  }

  Future<void> _logout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(LogoutLoadingState());
    emit(LogoutSuccessState());
    await _clearUserData();
  }

  Future<void> _changePassword(
      ChangePasswordEvent event, Emitter<AuthState> emit) async {
    var result = await _repository.changePassword(
      oldPassword: event.oldPassword,
      newPassword: event.newPassword,
    );
    result.fold((l) {
      ChangePasswordErrorState(l);
    }, (r) {
      emit(ChangePasswordSuccessState(r));
    });
  }

  Future<void> _uploadNationalId(
      UploadNationalIdEvent event, Emitter<AuthState> emit) async {
    emit(UploadNationalIdLoadingState());
    var res = await _repository.uploadNationalId(event.nationalId);
    res.fold((l) {
      print("ERORORORORORORO $l");
      emit(UploadNationalIdErrorState(l));
    }, (r) {
      emit(UploadNationalIdSuccessState(r));
    });
  }

  Future<void> _updateProfilePicture(
      UpdateProfilePictureEvent event, Emitter<AuthState> emit) async {
    add(AddImageEvent());
    if (state is AddImageSuccessState) {
      await _repository.changeProfileImage(event.profileImage);
    }
  }

  Future<void> _getProfile(
      GetProfileEvent event, Emitter<AuthState> emit) async {
    emit(GetProfileLoadingState());
    var res = await _repository.getProfile(event.id, event.userType);
    res.fold((l) {
      print("LLLLLLLLLLLLL $l");
      emit(GetProfileErrorState(l));
    }, (r) {
      print("r      $r");
      emit(GetProfileSuccessState(r));
    });
  }

  void _keepMeLoggedIn(KeepMeLoggedInEvent event, Emitter<AuthState> emit) {
    if (event.keepMeLoggedIn) {
      emit(KeepMeLoggedInState(false));
    } else {
      emit(KeepMeLoggedInState(true));
    }
  }

  void _selectSport(SelectSportEvent event, Emitter<AuthState> emit) {
    List<Sport> selectedSports = event.sports;
    if (event.sports.contains(event.sport)) {
      selectedSports.remove(event.sport);
      emit(SelectSportState(sports: selectedSports));
    } else {
      selectedSports.add(event.sport);
      emit(SelectSportState(sports: selectedSports));
    }
  }

  Future<void> _getSports(GetSportsEvent event, Emitter<AuthState> emit) async {
    emit(GetSportsLoadingState());
    var res = await _repository.getSports();
    res.fold((l) {
      emit(GetSportsErrorState(l));
    }, (r) {
      emit(GetSportsSuccessState(r));
    });
  }

  Future<void> _playSound(PlaySoundEvent event, Emitter<AuthState> emit) async {
    final audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource(event.sound));
    emit(PlaySoundState());
  }

  void _resetCodeTimer(ResetCodeTimerEvent event, Emitter<AuthState> emit) {
    timeToResendCodeTimer?.cancel();
    emit(ResetCodeTimerState(time: 0));
  }

  void _acceptConfirmTerms(
      AcceptConfirmTermsEvent event, Emitter<AuthState> emit) {
    if (event.accept) {
      emit(AcceptConfirmTermsState(false));
    } else {
      emit(AcceptConfirmTermsState(true));
    }
  }

  void _changePassVisibility(
      ChangePasswordVisibilityEvent event, Emitter<AuthState> emit) {
    if (event.visible) {
      emit(ChangePasswordVisibilityState(false));
    } else {
      emit(ChangePasswordVisibilityState(true));
    }
  }

  Future<void> _addImage(AddImageEvent event, Emitter<AuthState> emit) async {
    await _captureAndSaveGalleryImage().then((imagePicked) {
      emit(AddImageSuccessState(imagePicked: imagePicked!));
    });
  }

  void _determineGender(DetermineGenderEvent event, Emitter<AuthState> emit) {
    if(event.gender == 0) {
      emit(DetermineGenderState(isMale: true));
    }else{
      emit(DetermineGenderState(isMale: false));
    }
  }
}
