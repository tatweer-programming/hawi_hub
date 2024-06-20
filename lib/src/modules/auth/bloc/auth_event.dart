part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class RegisterPlayerEvent extends AuthEvent {
  final AuthPlayer authPlayer;

  RegisterPlayerEvent({required this.authPlayer});
}

class LoginPlayerEvent extends AuthEvent {
  final String email;
  final String password;

  LoginPlayerEvent({required this.email, required this.password});
}

class AddImageEvent extends AuthEvent {}

class GetSportsEvent extends AuthEvent {}

class SelectSportEvent extends AuthEvent {
  final List<Sport> sports;
  final Sport sport;

  SelectSportEvent({required this.sports, required this.sport});
}

class DeleteImageEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class VerifyCodeEvent extends AuthEvent {
  final String email;
  final String code;
  final String password;

  VerifyCodeEvent(
      {required this.email, required this.code, required this.password});
}

class ChangePasswordEvent extends AuthEvent {
  final String oldPassword;
  final String newPassword;

  ChangePasswordEvent({required this.oldPassword, required this.newPassword});
}

class LoginWithGoogleEvent extends AuthEvent {}

class LoginWithFacebookEvent extends AuthEvent {}

class SignupWithGoogleEvent extends AuthEvent {}

class SignupWithFacebookEvent extends AuthEvent {}

class OpenPdfEvent extends AuthEvent {}

class GetProfileEvent extends AuthEvent {
  final int id;
  final String userType;

  GetProfileEvent(this.id,this.userType);
}

class ResetPasswordEvent extends AuthEvent {
  final String email;
  final BuildContext context;

  ResetPasswordEvent(this.email, this.context);
}

class StartResendCodeTimerEvent extends AuthEvent {
  final int timeToResendCode;

  StartResendCodeTimerEvent(this.timeToResendCode);
}

class ResetCodeTimerEvent extends AuthEvent {
  final int timeToResendCode;

  ResetCodeTimerEvent(this.timeToResendCode);
}

class UploadNationalIdEvent extends AuthEvent {
  final File nationalId;

  UploadNationalIdEvent(this.nationalId);
}

class AcceptConfirmTermsEvent extends AuthEvent {
  final bool accept;

  AcceptConfirmTermsEvent(this.accept);
}

class ChangePasswordVisibilityEvent extends AuthEvent {
  final bool visible;

  ChangePasswordVisibilityEvent(this.visible);
}

class PlaySoundEvent extends AuthEvent {
  final String sound;

  PlaySoundEvent(this.sound);
}

class UpdateProfilePictureEvent extends AuthEvent {
  final File profileImage;

  UpdateProfilePictureEvent(this.profileImage);
}
