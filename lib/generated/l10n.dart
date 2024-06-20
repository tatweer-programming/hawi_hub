// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hawi Hub`
  String get appName {
    return Intl.message(
      'Hawi Hub',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Show in map`
  String get showInMap {
    return Intl.message(
      'Show in map',
      name: 'showInMap',
      desc: '',
      args: [],
    );
  }

  /// `Total Games`
  String get totalGames {
    return Intl.message(
      'Total Games',
      name: 'totalGames',
      desc: '',
      args: [],
    );
  }

  /// `Ratings`
  String get ratingsCount {
    return Intl.message(
      'Ratings',
      name: 'ratingsCount',
      desc: '',
      args: [],
    );
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `Available Times`
  String get availableTimes {
    return Intl.message(
      'Available Times',
      name: 'availableTimes',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `No ratings`
  String get noRatings {
    return Intl.message(
      'No ratings',
      name: 'noRatings',
      desc: '',
      args: [],
    );
  }

  /// `No games`
  String get noGames {
    return Intl.message(
      'No games',
      name: 'noGames',
      desc: '',
      args: [],
    );
  }

  /// `Add Rating`
  String get addRate {
    return Intl.message(
      'Add Rating',
      name: 'addRate',
      desc: '',
      args: [],
    );
  }

  /// `UPCOMING`
  String get upcoming {
    return Intl.message(
      'UPCOMING',
      name: 'upcoming',
      desc: '',
      args: [],
    );
  }

  /// `Sport`
  String get sport {
    return Intl.message(
      'Sport',
      name: 'sport',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Games`
  String get games {
    return Intl.message(
      'Games',
      name: 'games',
      desc: '',
      args: [],
    );
  }

  /// `Booking`
  String get booking {
    return Intl.message(
      'Booking',
      name: 'booking',
      desc: '',
      args: [],
    );
  }

  /// `Owner`
  String get owner {
    return Intl.message(
      'Owner',
      name: 'owner',
      desc: '',
      args: [],
    );
  }

  /// `Book Now`
  String get bookNow {
    return Intl.message(
      'Book Now',
      name: 'bookNow',
      desc: '',
      args: [],
    );
  }

  /// `Create Game`
  String get createGame {
    return Intl.message(
      'Create Game',
      name: 'createGame',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Minimum Booking`
  String get minimumBooking {
    return Intl.message(
      'Minimum Booking',
      name: 'minimumBooking',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get hours {
    return Intl.message(
      'Hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `Per Hour`
  String get perHour {
    return Intl.message(
      'Per Hour',
      name: 'perHour',
      desc: '',
      args: [],
    );
  }

  /// `SAR`
  String get sar {
    return Intl.message(
      'SAR',
      name: 'sar',
      desc: '',
      args: [],
    );
  }

  /// `Near by Venues`
  String get nearByVenues {
    return Intl.message(
      'Near by Venues',
      name: 'nearByVenues',
      desc: '',
      args: [],
    );
  }

  /// `Near by Games`
  String get nearByGames {
    return Intl.message(
      'Near by Games',
      name: 'nearByGames',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Slots`
  String get slots {
    return Intl.message(
      'Slots',
      name: 'slots',
      desc: '',
      args: [],
    );
  }

  /// `Only`
  String get only {
    return Intl.message(
      'Only',
      name: 'only',
      desc: '',
      args: [],
    );
  }

  /// `Players`
  String get players {
    return Intl.message(
      'Players',
      name: 'players',
      desc: '',
      args: [],
    );
  }

  /// `Join`
  String get join {
    return Intl.message(
      'Join',
      name: 'join',
      desc: '',
      args: [],
    );
  }

  /// `Host`
  String get host {
    return Intl.message(
      'Host',
      name: 'host',
      desc: '',
      args: [],
    );
  }

  /// `All Players`
  String get allPlayers {
    return Intl.message(
      'All Players',
      name: 'allPlayers',
      desc: '',
      args: [],
    );
  }

  /// `You should login first`
  String get loginFirst {
    return Intl.message(
      'You should login first',
      name: 'loginFirst',
      desc: '',
      args: [],
    );
  }

  /// `The ID card is being verified now`
  String get identificationPending {
    return Intl.message(
      'The ID card is being verified now',
      name: 'identificationPending',
      desc: '',
      args: [],
    );
  }

  /// `You must verify your account first `
  String get mustVerifyAccount {
    return Intl.message(
      'You must verify your account first ',
      name: 'mustVerifyAccount',
      desc: '',
      args: [],
    );
  }

  /// `File Uploaded`
  String get fileUploaded {
    return Intl.message(
      'File Uploaded',
      name: 'fileUploaded',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message(
      'Upload',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `My Wallet`
  String get myWallet {
    return Intl.message(
      'My Wallet',
      name: 'myWallet',
      desc: '',
      args: [],
    );
  }

  /// `SIGN UP`
  String get signUp {
    return Intl.message(
      'SIGN UP',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account ?`
  String get noAccount {
    return Intl.message(
      'Don’t have an account ?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Keep me logged in`
  String get keepMeLoggedIn {
    return Intl.message(
      'Keep me logged in',
      name: 'keepMeLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN`
  String get login {
    return Intl.message(
      'LOGIN',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get enterPassword {
    return Intl.message(
      'Please enter password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email`
  String get enterEmail {
    return Intl.message(
      'Please enter email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter username`
  String get enterUsername {
    return Intl.message(
      'Please enter username',
      name: 'enterUsername',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password ?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password ?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// ` Username`
  String get username {
    return Intl.message(
      ' Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// ` Password does not match`
  String get passwordDoesNotMatch {
    return Intl.message(
      ' Password does not match',
      name: 'passwordDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// ` Email`
  String get email {
    return Intl.message(
      ' Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter confirm password`
  String get enterConfirmPassword {
    return Intl.message(
      'Please enter confirm password',
      name: 'enterConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter new password`
  String get enterNewPassword {
    return Intl.message(
      'Please enter new password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get start {
    return Intl.message(
      'Get Started',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendCode {
    return Intl.message(
      'Send Code',
      name: 'sendCode',
      desc: '',
      args: [],
    );
  }

  /// `Received Code`
  String get receivedCode {
    return Intl.message(
      'Received Code',
      name: 'receivedCode',
      desc: '',
      args: [],
    );
  }

  /// `seconds`
  String get seconds {
    return Intl.message(
      'seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `You can resend code after `
  String get sendCodeAfter {
    return Intl.message(
      'You can resend code after ',
      name: 'sendCodeAfter',
      desc: '',
      args: [],
    );
  }

  /// `Password reset successfully`
  String get passwordResetSuccessfully {
    return Intl.message(
      'Password reset successfully',
      name: 'passwordResetSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Account Created Successfully`
  String get accountCreatedSuccessfully {
    return Intl.message(
      'Account Created Successfully',
      name: 'accountCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Email is not exists.`
  String get userNotFound {
    return Intl.message(
      'Email is not exists.',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Email is already exists.`
  String get emailAlreadyExist {
    return Intl.message(
      'Email is already exists.',
      name: 'emailAlreadyExist',
      desc: '',
      args: [],
    );
  }

  /// `Username is already exists.`
  String get usernameAlreadyExist {
    return Intl.message(
      'Username is already exists.',
      name: 'usernameAlreadyExist',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters.`
  String get shortPassword {
    return Intl.message(
      'Password must be at least 6 characters.',
      name: 'shortPassword',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email or password.`
  String get invalidEmailOrPassword {
    return Intl.message(
      'Invalid email or password.',
      name: 'invalidEmailOrPassword',
      desc: '',
      args: [],
    );
  }

  /// `Account LogedIn Successfully`
  String get loginSuccessfully {
    return Intl.message(
      'Account LogedIn Successfully',
      name: 'loginSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong.`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong.',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password !`
  String get wrongPassword {
    return Intl.message(
      'Wrong password !',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password has been changed successfully`
  String get passwordChangedSuccessfully {
    return Intl.message(
      'Password has been changed successfully',
      name: 'passwordChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Reset code sent successfully to `
  String get resetCodeSentSuccessfully {
    return Intl.message(
      'Reset code sent successfully to ',
      name: 'resetCodeSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Proof of identity has been added successfully`
  String get proofOfIdentityAddedSuccessfully {
    return Intl.message(
      'Proof of identity has been added successfully',
      name: 'proofOfIdentityAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get updateProfile {
    return Intl.message(
      'Update Profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Change `
  String get change {
    return Intl.message(
      'Change ',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `No comment`
  String get noComment {
    return Intl.message(
      'No comment',
      name: 'noComment',
      desc: '',
      args: [],
    );
  }

  /// `People Rate`
  String get peopleRate {
    return Intl.message(
      'People Rate',
      name: 'peopleRate',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get seeAll {
    return Intl.message(
      'See all',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Please enter code`
  String get enterCode {
    return Intl.message(
      'Please enter code',
      name: 'enterCode',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the Terms of Service and Privacy Policy.`
  String get agreeTerms {
    return Intl.message(
      'I agree to the Terms of Service and Privacy Policy.',
      name: 'agreeTerms',
      desc: '',
      args: [],
    );
  }

  /// `The file was rejected. Check the required information carefully and try again`
  String get rejectIdCard {
    return Intl.message(
      'The file was rejected. Check the required information carefully and try again',
      name: 'rejectIdCard',
      desc: '',
      args: [],
    );
  }

  /// `Choose Sport`
  String get chooseSport {
    return Intl.message(
      'Choose Sport',
      name: 'chooseSport',
      desc: '',
      args: [],
    );
  }

  /// `Working Hours`
  String get workingHours {
    return Intl.message(
      'Working Hours',
      name: 'workingHours',
      desc: '',
      args: [],
    );
  }

  /// `No Minimum Booking`
  String get noMinimumBooking {
    return Intl.message(
      'No Minimum Booking',
      name: 'noMinimumBooking',
      desc: '',
      args: [],
    );
  }

  /// `Please Activate Your Account`
  String get shouldActivate {
    return Intl.message(
      'Please Activate Your Account',
      name: 'shouldActivate',
      desc: '',
      args: [],
    );
  }

  /// `Always Open`
  String get alwaysOpen {
    return Intl.message(
      'Always Open',
      name: 'alwaysOpen',
      desc: '',
      args: [],
    );
  }

  /// `Weekend`
  String get weekend {
    return Intl.message(
      'Weekend',
      name: 'weekend',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `End time must be after start time`
  String get endTimeMustBeAfterStartTime {
    return Intl.message(
      'End time must be after start time',
      name: 'endTimeMustBeAfterStartTime',
      desc: '',
      args: [],
    );
  }

  /// `All fields are required`
  String get allFieldsIsRequired {
    return Intl.message(
      'All fields are required',
      name: 'allFieldsIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Request Sent Successfully`
  String get requestSent {
    return Intl.message(
      'Request Sent Successfully',
      name: 'requestSent',
      desc: '',
      args: [],
    );
  }

  /// `Minimum Players`
  String get minPlayers {
    return Intl.message(
      'Minimum Players',
      name: 'minPlayers',
      desc: '',
      args: [],
    );
  }

  /// `Maximum Players`
  String get maxPlayers {
    return Intl.message(
      'Maximum Players',
      name: 'maxPlayers',
      desc: '',
      args: [],
    );
  }

  /// `Place`
  String get place {
    return Intl.message(
      'Place',
      name: 'place',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Accessibility`
  String get accessibility {
    return Intl.message(
      'Accessibility',
      name: 'accessibility',
      desc: '',
      args: [],
    );
  }

  /// `Public`
  String get public {
    return Intl.message(
      'Public',
      name: 'public',
      desc: '',
      args: [],
    );
  }

  /// `CHECK YOUR NETWORK`
  String get checkYourNetwork {
    return Intl.message(
      'CHECK YOUR NETWORK',
      name: 'checkYourNetwork',
      desc: '',
      args: [],
    );
  }

  /// `Email is not exists`
  String get emailNotExists {
    return Intl.message(
      'Email is not exists',
      name: 'emailNotExists',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get userName {
    return Intl.message(
      'Username',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `What is the Howie Hub application?\n\nIt is an application that connects stadium owners with tenants, facilitating the process of booking stadiums individually or collectively.\n\nWho can use the Howie Hub application?\n\nAnyone can download and use the app, but it specifically targets young people in Saudi Arabia.\n\nWhat services does the application provide?\n\nBook pitches individually:\nSelect the stadium you want.\nChoose the appropriate date and time.\nComplete the payment process.\nCreate group bookings and share them with friends:\nSelect the stadium you want.\nChoose the appropriate date and time.\nDetermine the number of players.\nCreate a booking link and share with your friends.\nCreate group bookings open to all app users:\nSelect the stadium you want.\nChoose the appropriate date and time.\nDetermine the number of players.\nCreate a booking link and share it with everyone.\nHow is payment made in the Howie Hub application?\n\nPayment is made by credit card or online payment card.\n\nWhat is the percentage of the company that owns the application of the reservation value?\n\nThe percentage of the reservation value of the company that owns the application varies depending on the type of reservation.\n\nHow can I add a playground to the app?\n\nIf you are a stadium owner, you can contact the company that owns the application through https://www.infohub.com/ to learn more about how to add your stadium to the application.\n\nHow can I contact the company that owns the application?\n\nYou can contact the company that owns the application through https://www.infohub.com/\n\nAre there any restrictions or specific conditions for using the application?\n\nThere are no restrictions or conditions for using the app, but you must respect all users on the app and refrain from any abusive or illegal behavior.\n\nAre there any behaviors prohibited on the application?\n\nYes, there are some behaviors that are prohibited on the application, such as:\n\nBullying or harassment.\nPosting hate speech or offensive content.\nSharing personal or sensitive information.\nUse the application for illegal purposes.\nWhat happens if I violate the terms of use?\n\nIf you violate the Terms of Use, your account may be permanently banned from the application.\n\nCan I cancel my account?\n\nYes, you can cancel your account at any time.\n\nCan I change my account information?\n\nYes, you can change your account information at any time.\n\nHow can I get help using the application?\n\nYou can review the help center in the application or contact the company that owns the application through https://www.infohub.com/\n\nIs the Howie Hub application safe?\n\nYes, Howie Hub is very secure. We use the latest security technologies to protect users' data.\n\nIs my data shared with anyone else?\n\nNo, your data is not shared with anyone else unless you have expressly agreed to this.\n\nWhat is the privacy policy of the Howie Hub application?\n\nYou can review the Howie Hub privacy policy at https://www.infohub.com/\n\nIs there anything else I should know?\n\nWe advise you to read the terms of use and privacy policy carefully before using the application.\n\nThank you for using Howie Hub!\n\nnote:\nThis FAQ may be updated from time to time. Please check this page periodically to see the latest changes.`
  String get questions {
    return Intl.message(
      'What is the Howie Hub application?\n\nIt is an application that connects stadium owners with tenants, facilitating the process of booking stadiums individually or collectively.\n\nWho can use the Howie Hub application?\n\nAnyone can download and use the app, but it specifically targets young people in Saudi Arabia.\n\nWhat services does the application provide?\n\nBook pitches individually:\nSelect the stadium you want.\nChoose the appropriate date and time.\nComplete the payment process.\nCreate group bookings and share them with friends:\nSelect the stadium you want.\nChoose the appropriate date and time.\nDetermine the number of players.\nCreate a booking link and share with your friends.\nCreate group bookings open to all app users:\nSelect the stadium you want.\nChoose the appropriate date and time.\nDetermine the number of players.\nCreate a booking link and share it with everyone.\nHow is payment made in the Howie Hub application?\n\nPayment is made by credit card or online payment card.\n\nWhat is the percentage of the company that owns the application of the reservation value?\n\nThe percentage of the reservation value of the company that owns the application varies depending on the type of reservation.\n\nHow can I add a playground to the app?\n\nIf you are a stadium owner, you can contact the company that owns the application through https://www.infohub.com/ to learn more about how to add your stadium to the application.\n\nHow can I contact the company that owns the application?\n\nYou can contact the company that owns the application through https://www.infohub.com/\n\nAre there any restrictions or specific conditions for using the application?\n\nThere are no restrictions or conditions for using the app, but you must respect all users on the app and refrain from any abusive or illegal behavior.\n\nAre there any behaviors prohibited on the application?\n\nYes, there are some behaviors that are prohibited on the application, such as:\n\nBullying or harassment.\nPosting hate speech or offensive content.\nSharing personal or sensitive information.\nUse the application for illegal purposes.\nWhat happens if I violate the terms of use?\n\nIf you violate the Terms of Use, your account may be permanently banned from the application.\n\nCan I cancel my account?\n\nYes, you can cancel your account at any time.\n\nCan I change my account information?\n\nYes, you can change your account information at any time.\n\nHow can I get help using the application?\n\nYou can review the help center in the application or contact the company that owns the application through https://www.infohub.com/\n\nIs the Howie Hub application safe?\n\nYes, Howie Hub is very secure. We use the latest security technologies to protect users\' data.\n\nIs my data shared with anyone else?\n\nNo, your data is not shared with anyone else unless you have expressly agreed to this.\n\nWhat is the privacy policy of the Howie Hub application?\n\nYou can review the Howie Hub privacy policy at https://www.infohub.com/\n\nIs there anything else I should know?\n\nWe advise you to read the terms of use and privacy policy carefully before using the application.\n\nThank you for using Howie Hub!\n\nnote:\nThis FAQ may be updated from time to time. Please check this page periodically to see the latest changes.',
      name: 'questions',
      desc: '',
      args: [],
    );
  }

  /// `Howie Hub application terms and conditions\nintroduction:\n\nWelcome to the Howie Hub app! This application aims to connect stadium owners with tenants, facilitating the process of booking stadiums individually or collectively. Before using the application, please read these terms and conditions carefully.\n\n1. General information:\n\nApplication name: Howie Hub\nApplication type: Sports application\nThe application's target audience: youth in the Kingdom of Saudi Arabia\nServices provided by the application:\nBook pitches individually\nCreate group bookings and share them with friends\nCreate group bookings that are open to all app users\nApplication business model:\nThe user pays the full reservation price.\nThe company that owns the application receives a percentage of ......% of the reservation value after deducting the bank commissions for electronic payment service providers, which are ..........%.\nThe stadium owner gets the rest of the reservation value.\n2. Legal information:\n\nCountry of headquarters of the company that owns the application: Kingdom of Saudi Arabia\n\n3. Privacy Policy:\n\nData collection:\nNormal user:\nthe name\nthe age\nE-mail\nStadium owner:\nSome documents are required to authenticate the stadium owner’s account and documents to prove his ownership of the places before agreeing to display them in the application. All required documents are shown in the legal requirements screen. \ndata usage:\nThese data and documents are kept and the data is only shared with the competent legal authorities only when needed and in accordance with Saudi laws.\nData protection:\nAll legal measures are taken to protect user data.\n4. Terms of use:\nAcceptance of the Terms: Using the application means accepting these terms and conditions.\nthe accounts:\nCreate a free user account.\nVerifying the identity of stadium owners.\nReservations:\nUsers can book pitches individually or as a group.\nThe stadium owner can accept or reject reservations.\nThe reservation value is paid by the user.\nThe company that owns the application receives a percentage of the reservation value.\nThe stadium owner gets the rest of the reservation value.\nBehaviors:\nYou must respect all users on the application and refrain from any abusive or illegal behavior.\nthe responsibility:\nThe user is responsible for all his actions on the application.\nThe Company does not bear any responsibility for any damages resulting from the use of the application.\nthe changes:\nThe Company reserves the right to modify these terms and conditions at any time without prior notice.\nRegulating law:\nThese terms and conditions are subject to the laws of the Kingdom of Saudi Arabia.\n5. Dispute resolution:\nIf any dispute arises between the User and the Application, every effort will be made to resolve it amicably.\nIf the amicable solution fails, arbitration is resorted to at the Commercial Arbitration Center of the Kingdom of Saudi Arabia.\n6. Contact:\n\nYou can contact the company that owns the application through...\nnote:\nThese terms and conditions may be updated from time to time. Please check this page periodically to see the latest changes.\nThank you for using Howie Hub!`
  String get termsAndConditions {
    return Intl.message(
      'Howie Hub application terms and conditions\nintroduction:\n\nWelcome to the Howie Hub app! This application aims to connect stadium owners with tenants, facilitating the process of booking stadiums individually or collectively. Before using the application, please read these terms and conditions carefully.\n\n1. General information:\n\nApplication name: Howie Hub\nApplication type: Sports application\nThe application\'s target audience: youth in the Kingdom of Saudi Arabia\nServices provided by the application:\nBook pitches individually\nCreate group bookings and share them with friends\nCreate group bookings that are open to all app users\nApplication business model:\nThe user pays the full reservation price.\nThe company that owns the application receives a percentage of ......% of the reservation value after deducting the bank commissions for electronic payment service providers, which are ..........%.\nThe stadium owner gets the rest of the reservation value.\n2. Legal information:\n\nCountry of headquarters of the company that owns the application: Kingdom of Saudi Arabia\n\n3. Privacy Policy:\n\nData collection:\nNormal user:\nthe name\nthe age\nE-mail\nStadium owner:\nSome documents are required to authenticate the stadium owner’s account and documents to prove his ownership of the places before agreeing to display them in the application. All required documents are shown in the legal requirements screen. \ndata usage:\nThese data and documents are kept and the data is only shared with the competent legal authorities only when needed and in accordance with Saudi laws.\nData protection:\nAll legal measures are taken to protect user data.\n4. Terms of use:\nAcceptance of the Terms: Using the application means accepting these terms and conditions.\nthe accounts:\nCreate a free user account.\nVerifying the identity of stadium owners.\nReservations:\nUsers can book pitches individually or as a group.\nThe stadium owner can accept or reject reservations.\nThe reservation value is paid by the user.\nThe company that owns the application receives a percentage of the reservation value.\nThe stadium owner gets the rest of the reservation value.\nBehaviors:\nYou must respect all users on the application and refrain from any abusive or illegal behavior.\nthe responsibility:\nThe user is responsible for all his actions on the application.\nThe Company does not bear any responsibility for any damages resulting from the use of the application.\nthe changes:\nThe Company reserves the right to modify these terms and conditions at any time without prior notice.\nRegulating law:\nThese terms and conditions are subject to the laws of the Kingdom of Saudi Arabia.\n5. Dispute resolution:\nIf any dispute arises between the User and the Application, every effort will be made to resolve it amicably.\nIf the amicable solution fails, arbitration is resorted to at the Commercial Arbitration Center of the Kingdom of Saudi Arabia.\n6. Contact:\n\nYou can contact the company that owns the application through...\nnote:\nThese terms and conditions may be updated from time to time. Please check this page periodically to see the latest changes.\nThank you for using Howie Hub!',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Terms And Conditions`
  String get preferenceAndPrivacy {
    return Intl.message(
      'Terms And Conditions',
      name: 'preferenceAndPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Common Questions`
  String get commonQuestions {
    return Intl.message(
      'Common Questions',
      name: 'commonQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Please add what is required below from the file`
  String get addRequiredPdf {
    return Intl.message(
      'Please add what is required below from the file',
      name: 'addRequiredPdf',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one letter`
  String get passMustContainLetter {
    return Intl.message(
      'Password must contain at least one letter',
      name: 'passMustContainLetter',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one lowercase letter`
  String get passMustContainLowerCase {
    return Intl.message(
      'Password must contain at least one lowercase letter',
      name: 'passMustContainLowerCase',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one uppercase letter`
  String get passMustContainUpperCase {
    return Intl.message(
      'Password must contain at least one uppercase letter',
      name: 'passMustContainUpperCase',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one special character`
  String get passMustContainSpecialChar {
    return Intl.message(
      'Password must contain at least one special character',
      name: 'passMustContainSpecialChar',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one number`
  String get passMustContainNumber {
    return Intl.message(
      'Password must contain at least one number',
      name: 'passMustContainNumber',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Club Rate`
  String get clubRate {
    return Intl.message(
      'Club Rate',
      name: 'clubRate',
      desc: '',
      args: [],
    );
  }

  /// `Owner Rate`
  String get ownerRate {
    return Intl.message(
      'Owner Rate',
      name: 'ownerRate',
      desc: '',
      args: [],
    );
  }

  /// `Add Comment`
  String get addComment {
    return Intl.message(
      'Add Comment',
      name: 'addComment',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `hey! to share our app visit `
  String get shareApp {
    return Intl.message(
      'hey! to share our app visit ',
      name: 'shareApp',
      desc: '',
      args: [],
    );
  }

  /// `Private`
  String get private {
    return Intl.message(
      'Private',
      name: 'private',
      desc: '',
      args: [],
    );
  }

  /// `No Alerts`
  String get noAlerts {
    return Intl.message(
      'No Alerts',
      name: 'noAlerts',
      desc: '',
      args: [],
    );
  }

  /// `There is a conflict with another booking`
  String get bookingConflict {
    return Intl.message(
      'There is a conflict with another booking',
      name: 'bookingConflict',
      desc: '',
      args: [],
    );
  }

  /// `Booking Added Successfully`
  String get bookingSuccess {
    return Intl.message(
      'Booking Added Successfully',
      name: 'bookingSuccess',
      desc: '',
      args: [],
    );
  }

  /// `No enough balance`
  String get noEnoughBalance {
    return Intl.message(
      'No enough balance',
      name: 'noEnoughBalance',
      desc: '',
      args: [],
    );
  }

  /// `No Items Found`
  String get noItemsFound {
    return Intl.message(
      'No Items Found',
      name: 'noItemsFound',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get saved {
    return Intl.message(
      'Saved',
      name: 'saved',
      desc: '',
      args: [],
    );
  }

  /// `Choose Stadium first`
  String get chooseStadium {
    return Intl.message(
      'Choose Stadium first',
      name: 'chooseStadium',
      desc: '',
      args: [],
    );
  }

  /// `Choose Date first`
  String get chooseDate {
    return Intl.message(
      'Choose Date first',
      name: 'chooseDate',
      desc: '',
      args: [],
    );
  }

  /// `Game Created Successfully`
  String get gameCreated {
    return Intl.message(
      'Game Created Successfully',
      name: 'gameCreated',
      desc: '',
      args: [],
    );
  }

  /// `Please enter number of players`
  String get minPlayersRequired {
    return Intl.message(
      'Please enter number of players',
      name: 'minPlayersRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter number of players`
  String get maxPlayersRequired {
    return Intl.message(
      'Please enter number of players',
      name: 'maxPlayersRequired',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Booking time is in the past`
  String get bookingTimeInPast {
    return Intl.message(
      'Booking time is in the past',
      name: 'bookingTimeInPast',
      desc: '',
      args: [],
    );
  }

  /// `End time must be after start time`
  String get endTimeBeforeStartTime {
    return Intl.message(
      'End time must be after start time',
      name: 'endTimeBeforeStartTime',
      desc: '',
      args: [],
    );
  }

  /// `Start time is too soon`
  String get startTimeTooSoon {
    return Intl.message(
      'Start time is too soon',
      name: 'startTimeTooSoon',
      desc: '',
      args: [],
    );
  }

  /// `Joined Game Successfully`
  String get joinedGame {
    return Intl.message(
      'Joined Game Successfully',
      name: 'joinedGame',
      desc: '',
      args: [],
    );
  }

  /// `Already Joined Game`
  String get alreadyJoined {
    return Intl.message(
      'Already Joined Game',
      name: 'alreadyJoined',
      desc: '',
      args: [],
    );
  }

  /// `Feedbacks`
  String get feedbacks {
    return Intl.message(
      'Feedbacks',
      name: 'feedbacks',
      desc: '',
      args: [],
    );
  }

  /// `View Feedbacks`
  String get viewFeedbacks {
    return Intl.message(
      'View Feedbacks',
      name: 'viewFeedbacks',
      desc: '',
      args: [],
    );
  }

  /// `No Feedbacks`
  String get noFeedbacks {
    return Intl.message(
      'No Feedbacks',
      name: 'noFeedbacks',
      desc: '',
      args: [],
    );
  }

  /// `home`
  String get home {
    return Intl.message(
      'home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `book`
  String get book {
    return Intl.message(
      'book',
      name: 'book',
      desc: '',
      args: [],
    );
  }

  /// `play`
  String get play {
    return Intl.message(
      'play',
      name: 'play',
      desc: '',
      args: [],
    );
  }

  /// `Rates`
  String get rates {
    return Intl.message(
      'Rates',
      name: 'rates',
      desc: '',
      args: [],
    );
  }

  /// `Add Feedback`
  String get addFeedback {
    return Intl.message(
      'Add Feedback',
      name: 'addFeedback',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
