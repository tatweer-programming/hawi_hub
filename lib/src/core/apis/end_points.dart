class EndPoints {

  static const String login = '/Owner/Login';
  static const String register = '/Owner/Signup';
  static const String verifyResetCode = '/Owner/VerifyResetCode';
  static const String resetPass = '/Owner/ResetPassword';
  static const String changeImageProfile = '/Owner/ChangeDetails';
  static const String changePassword = '/Owner/ChangePassword';
  static const String verification = '/Owner/Verification';
  static const String uploadProof = '/Owner/UploadProofOfIdentity';
  static const String verifyCode = '/verifycode';
  static const String deleteProfile = '/deleteprofile';
  static const String changeProfile = '/changeprofile';
  static const String getBanners = '/Banner';
  static const String getSports = '/Category';
  static const String getProfile = '/user';
  static const String getPlaces = '/Stadium/GetByCity/';
  static const String getPlaceBookings = "";

  /// chat
  static const String getConnection = '/Hub/negotiate?negotiateVersion=1';
  static const String addConnectionId = '/Hub/AddOwnerConnectionId/';
  static const String addConversation = '/Hub/AddConversation';
  static const String getOwnerConversations = '/Hub/OwnerConversations/';
  static const String getConversation = '/Hub/Conversation/';
  static const String uploadConversationAttachment =
      '/Hub/UploadConversationAttachment';
}
