class EndPoints {
  /// auth
  static const String login = '/Player/Login';
  static const String register = '/Player/Signup';
  static const String verifyResetCode = '/Player/VerifyResetCode';
  static const String resetPass = '/Player/ResetPassword';
  static const String changeImageProfile = '/Player/ChangeDetails';
  static const String changePassword = '/Player/ChangePassword';
  static const String verification = '/Player/Verification';
  static const String uploadProof = '/Player/UploadProofOfIdentity';
  static const String verifyCode = '/verifycode';


  static const String getBanners = '/Banner';
  static const String getSports = '/Category';
  static const String getPlaces = '/Stadium/GetByCity/';
  static const String getPlaceBookings = "";

  /// chat
  static const String getConnection = '/Hub/negotiate?negotiateVersion=1';
  static const String addConnectionId = '/Hub/AddPlayerConnectionId/';
  static const String addConversation = '/Hub/AddConversation';
  static const String getPlayerConversations = '/Hub/PlayerConversations/';
  static const String getConversation = '/Hub/Conversation/';
  static const String uploadConversationAttachment =
      '/Hub/UploadConversationAttachment';
}
