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

  /// profile
  static const String addOwnerFeedback = '/Player/AddOwnerReview/';
  static const String getFeedbacks = '/Player/GetPlayerReviews/';

  /// payment
  static const String getPaymentStatus = '/v2/GetPaymentStatus';
  static const String updateWallet = '/Player/UpdateWallet/';
  static const String updatePendingWallet = '/Player/UpdatePendingWallet/';

  static const String getBanners = '/Banner';
  static const String getSports = '/Category';
  static const String getPlaces = '/Stadium/GetByCity/';
  static const String getPlaceBookings = "/Stadium/StadiumReservationsTimes/";
  static const String bookPlace = '/Player/ReserveStadium/';
  static const String addPlaceToFavourites = '/Player/AddStadiumToFavorite/';
  static const String deletePlaceFromFavourites = "/Player/DeleteFromFavorite/";
  static const String getPlaceFeedbacks = '/Stadium/GetStadiumReviews/';
  static const String getPlace = "/Stadium/GetByStadiumId/";
  static const String addPlaceFeedback = '/Stadium/StadiumReview/';

  /// games
  static const String getGames = '/Stadium/Games/City/';
  static const String createGame = '/Player/AddStadiumGame/';
  static const String joinGame = '/Player/JoinGame/';
  static const String getGame = "/Stadium/Games/";

  /// chat
  static const String getConnection = '/Hub/negotiate?negotiateVersion=1';
  static const String addConnectionId = '/Hub/AddPlayerConnectionId/';
  static const String addConversation = '/Hub/AddConversation';
  static const String getPlayerConversations = '/Hub/PlayerConversations/';
  static const String getConversation = '/Hub/Conversation/';
  static const String uploadConversationAttachment =
      '/Hub/UploadConversationAttachment';

  static const String getNotifications = '/Hub/PlayerNotifications/';
  static const String markAsRead = "/Hub/MarkPlayerNotificationAsRead/";
  static const String saveNotificationToOwner = '/Hub/AddOwnerNotification/';
}
