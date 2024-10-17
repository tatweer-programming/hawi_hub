class EndPoints {
  /// auth
  static const String login = '/Player/Login';
  static const String register = '/Player/Signup';
  static const String confirmEmail = '/Player/ConfirmEmail/';
  static const String verifyConfirmEmail = '/Player/VerifyConfirmEmail/';
  static const String verifyResetCode = '/Player/VerifyResetCode';
  static const String resetPass = '/Player/ResetPassword';
  static const String changeImageProfile =
      '/Player/UploadProfilePicture'; // Updated
  static const String changePassword = '/Player/ChangePassword';
  static const String verification = '/Player/Verification';
  static const String uploadProof = '/Player/UploadProofOfIdentity';

  /// profile
  static const String addOwnerFeedback = '/Player/ReviewOwner/'; // Updated
  static const String addPlayerFeedback = '/Player/ReviewPlayer/'; // Updated
  static const String getOwnerFeedbacks = '/Player/OwnersReviews/'; // Updated
  static const String getPlayerFeedbacks = '/Owner/PlayersReviews/'; // Updated

  /// payment
  static const String getPaymentStatus = '/v2/GetPaymentStatus';
  static const String updateWallet = '/Player/UpdateWallet/';
  static const String updatePendingWallet = '/Player/UpdatePendingWallet/';

  /// banners and categories
  static const String getBanners = '/Banner';
  static const String getSports = '/Category';

  /// places
  static const String getPlaces = '/Stadium/City/';
  static const String getPlaceBookings = "/Stadium/StadiumReservationsTimes/";
  static const String bookPlace = '/Player/ReserveStadium/';
  static const String addPlaceToFavourites = '/Player/Favorite/';
  static const String deletePlaceFromFavourites = "/Player/Favorite/";
  static const String getPlaceFeedbacks = '/Stadium/Reviews/'; // Updated
  static const String getPlace = "/Stadium/"; // Updated
  static const String addPlaceFeedback = '/Player/ReviewStadium/'; // Updated
  static const String getUpcomingBookings = "/Player/StadiumGame/"; // Updated

  /// games
  static const String getGamesByCity = '/Stadium/Games/City/';
  static const String getGameById = '/Stadium/Games/';
  static const String createGame = '/Player/StadiumGame/'; // Updated
  static const String joinGame = '/Player/JoinGame/';
  static const String leaveGame = "";

  /// chat
  static const String getConnection = '/Hub/negotiate?negotiateVersion=1';
  static const String addConnectionId = '/Hub/AddPlayerConnectionId/';
  static const String addConversationBetweenPlayerAndOwner =
      '/Hub/ConversationBetweenPlayerAndOwner';
  static const String addConversationBetweenAdminAndPlayer =
      '/Hub/ConversationBetweenAdminAndPlayer';
  static const String getPlayerConversationsWithOwners =
      '/Hub/PlayerConversationsWithOwners/';
  static const String getPlayerConversationsWithAdmins =
      '/Hub/PlayerConversationsWithAdmins/';
  static const String getConversationOwnerWithPlayer =
      '/Hub/ConversationOwnerWithPlayer/';
  static const String getConversationAdminWithPlayer =
      '/Hub/ConversationAdminWithPlayer/';
  static const String uploadConversationAttachment =
      '/Hub/UploadConversationAttachment';

  /// notifications
  static const String getNotifications = '/Hub/PlayerNotifications/';
  static const String markAsRead = '/Hub/MarkPlayerNotificationAsRead/';
  static const String saveNotificationToOwner = '/Hub/AddOwnerNotification/';
}
