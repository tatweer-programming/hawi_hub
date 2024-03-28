part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

// register player
class RegisterPlayerLoadingState extends AuthState {}

class RegisterPlayerSuccessState extends AuthState {}

class RegisterPlayerErrorState extends AuthState {
  final String error;

  RegisterPlayerErrorState(this.error);
}

// get sports
class GetSportsLoadingState extends AuthState {}

class GetSportsSuccessState extends AuthState {}

class GetSportsErrorState extends AuthState {
  final String error;

  GetSportsErrorState(this.error);
}

// login player
class LoginPlayerLoadingState extends AuthState {}

class LoginPlayerSuccessState extends AuthState {}

class LoginPlayerErrorState extends AuthState {
  final String error;

  LoginPlayerErrorState(this.error);
}

class AcceptConfirmTermsState extends AuthState {
  final bool accept;

  AcceptConfirmTermsState(this.accept);
}

class ChangePasswordVisibilityState extends AuthState {
  final bool visible;

  ChangePasswordVisibilityState(this.visible);
}

class AddProfilePictureSuccessState extends AuthState {
  final File profilePictureFile;

  AddProfilePictureSuccessState({required this.profilePictureFile});
}

class SelectSportState extends AuthState {
  final List<Sport> sports;

  SelectSportState({required this.sports});
}
