
class AuthPlayer {
  final String userName;
  final String email;
  final String password;
  final String birthDate;
  final int gender;
  final String? profilePictureUrl;

  AuthPlayer({
    required this.password,
    required this.userName,
    required this.birthDate,
    required this.email,
    required this.gender,
    required this.profilePictureUrl,
  });
  Map<String, dynamic> toJson()  {
    return {
      "userName": userName,
      "gender": gender,
      "email": email,
      "birthDate": birthDate,
      "password": password,
      // "profilePictureUrl": profilePictureUrl
    };
  }
}
