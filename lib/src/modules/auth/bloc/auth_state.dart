part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthError extends AuthState {
  final Exception exception;

  AuthError(this.exception);
}

// register player
class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  final String value;

  RegisterSuccessState({required this.value});
}

class RegisterErrorState extends AuthError {
  RegisterErrorState(super.exception);
}
// Signup google

class SignupWithGoogleLoadingState extends AuthState {}

class SignupWithGoogleSuccessState extends AuthState {
  final AuthPlayer authPlayer;

  SignupWithGoogleSuccessState(this.authPlayer);
}

class SignupWithGoogleErrorState extends AuthError {
  SignupWithGoogleErrorState(super.exception);
}

// Signup facebook
class SignupWithFacebookLoadingState extends AuthState {}

class SignupWithFacebookSuccessState extends AuthState {
  final AuthPlayer authPlayer;

  SignupWithFacebookSuccessState(this.authPlayer);
}

class SignupWithFacebookErrorState extends AuthError {
  SignupWithFacebookErrorState(super.exception);
}

// verifyCode

class VerifyCodeLoadingState extends AuthState {}

class VerifyCodeSuccessState extends AuthState {
  final String value;

  VerifyCodeSuccessState({required this.value});
}

class VerifyCodeErrorState extends AuthError {
  VerifyCodeErrorState(super.exception);
}

// verifyEmail

class VerifyConfirmEmailLoadingState extends AuthState {}

class VerifyConfirmEmailSuccessState extends AuthState {
  final String value;

  VerifyConfirmEmailSuccessState({required this.value});
}

class VerifyConfirmEmailErrorState extends AuthError {
  VerifyConfirmEmailErrorState(super.exception);
}

// ConfirmEmail

class ConfirmEmailLoadingState extends AuthState {}

class ConfirmEmailSuccessState extends AuthState {
  final String value;

  ConfirmEmailSuccessState({required this.value});
}

class ConfirmEmailErrorState extends AuthError {
  ConfirmEmailErrorState(super.exception);
}

// get My Profile
class GetProfileLoadingState extends AuthState {}

class GetProfileSuccessState extends AuthState {
  final User user;

  GetProfileSuccessState(this.user);
}

class GetProfileErrorState extends AuthError {
  GetProfileErrorState(super.exception);
}

// login player
class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final String value;

  LoginSuccessState(this.value);
}

class LoginErrorState extends AuthError {
  LoginErrorState(super.exception);
}
// Change pass

class ChangePasswordErrorState extends AuthError {
  ChangePasswordErrorState(super.exception);
}

class ChangePasswordSuccessState extends AuthState {
  final String value;

  ChangePasswordSuccessState(this.value);
}

// logout player
class LogoutLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {}

// Reset Password
class ResetPasswordLoadingState extends AuthState {}

class ResetPasswordSuccessState extends AuthState {
  final String message;

  ResetPasswordSuccessState(this.message);
}

class ResetPasswordErrorState extends AuthError {
  ResetPasswordErrorState(super.exception);
}

// accept confirm terms
class AcceptConfirmTermsState extends AuthState {
  final bool accept;

  AcceptConfirmTermsState(this.accept);
}

// update profile
class UpdateProfileLoadingState extends AuthState {}

class UpdateProfileSuccessfulState extends AuthState {}

class UpdateProfileErrorState extends AuthError {
  UpdateProfileErrorState(super.exception);
}

class ChangePasswordVisibilityState extends AuthState {
  final bool visible;

  ChangePasswordVisibilityState(this.visible);
}

class AddImageSuccessState extends AuthState {
  final File? imagePicked;

  AddImageSuccessState({required this.imagePicked});
}

// upload national id
class UploadNationalIdSuccessState extends AuthState {
  final String msg;

  UploadNationalIdSuccessState(this.msg);
}

class UploadNationalIdLoadingState extends AuthState {}

class UploadNationalIdErrorState extends AuthError {
  UploadNationalIdErrorState(super.exception);
}

// delete image
class DeleteImageState extends AuthState {}

// open pdf
class OpenPdfState extends AuthState {}

// timer resend code
class ChangeTimeToResendCodeState extends AuthState {
  final int time;

  ChangeTimeToResendCodeState({required this.time});
}

class ResetCodeTimerState extends AuthState {
  final int time;

  ResetCodeTimerState({required this.time});
}

// play sound
class PlaySoundState extends AuthState {}

// get sports
class GetSportsLoadingState extends AuthState {}

class GetSportsSuccessState extends AuthState {
  final List<Sport> sports;

  GetSportsSuccessState(this.sports);
}

class GetSportsErrorState extends AuthError {
  GetSportsErrorState(super.exception);
}

class SelectSportState extends AuthState {
  final List<Sport> sports;

  SelectSportState({required this.sports});
}

// accept confirm terms
class KeepMeLoggedInState extends AuthState {
  final bool keepMeLoggedIn;

  KeepMeLoggedInState(this.keepMeLoggedIn);
}

class ShowBirthDateDialogState extends AuthState {}

class DetermineGenderState extends AuthState {
  final bool isMale;

  DetermineGenderState({required this.isMale});
}
