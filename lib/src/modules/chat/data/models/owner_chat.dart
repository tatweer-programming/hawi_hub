
class OwnerChat {
  final int ownerId;
  final String userName;
  final String? profilePictureUrl;

  const OwnerChat({
    required this.ownerId,
    required this.userName,
    required this.profilePictureUrl,
  });
  factory OwnerChat.fromJson(Map<String, dynamic> json) {
    return OwnerChat(
      ownerId: json["ownerId"],
      userName: json["userName"],
      profilePictureUrl: json["profilePictureUrl"],
    );
  }
}
