part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
class RegisterPlayerEvent extends AuthEvent {
  final Player player;

  RegisterPlayerEvent({required this.player});
}class LoginPlayerEvent extends AuthEvent {
  final String email;
  final String password;

  LoginPlayerEvent({required this.email, required this.password});

}
class AddProfilePictureEvent extends AuthEvent {}
class AcceptConfirmTermsEvent extends AuthEvent {
  final bool accept;

  AcceptConfirmTermsEvent(this.accept);
}
