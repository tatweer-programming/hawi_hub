
class AuthPlayer {
  final String userName;
  final String email;
  final String password;
  final String? profilePictureUrl;

  AuthPlayer({
    required this.password,
    required this.userName,
    required this.email,
    required this.profilePictureUrl,
  });

}