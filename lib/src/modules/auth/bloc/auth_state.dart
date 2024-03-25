part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class RegisterPlayerLoadingState extends AuthState {}
class RegisterPlayerSuccessState extends AuthState {}

class LoginPlayerLoadingState extends AuthState {}
class LoginPlayerSuccessState extends AuthState {}

class AcceptConfirmTermsState extends AuthState {
  final bool accept;

  AcceptConfirmTermsState(this.accept);
}
class AddProfilePictureSuccessState extends AuthState {
  final File profilePictureFile;

  AddProfilePictureSuccessState({required this.profilePictureFile});

}