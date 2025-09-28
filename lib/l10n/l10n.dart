import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'No noise, just the Edge'**
  String get app_title;

  /// No description provided for @auth_form_input_email.
  ///
  /// In en, this message translates to:
  /// **'INPUT EMAIL'**
  String get auth_form_input_email;

  /// No description provided for @auth_form_signIn.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN'**
  String get auth_form_signIn;

  /// No description provided for @auth_form_signInSignUp.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN/SIGN UP'**
  String get auth_form_signInSignUp;

  /// No description provided for @auth_success_sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code successfully'**
  String get auth_success_sendCode;

  /// No description provided for @auth_failed_sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code failed'**
  String get auth_failed_sendCode;

  /// No description provided for @auth_message_checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get auth_message_checkYourEmail;

  /// No description provided for @auth_message_weveSendA6DigitCodeTo.
  ///
  /// In en, this message translates to:
  /// **'We\'ve Send a 6 digit code to:'**
  String get auth_message_weveSendA6DigitCodeTo;

  /// No description provided for @auth_resendCode.
  ///
  /// In en, this message translates to:
  /// **'resend code'**
  String get auth_resendCode;

  /// No description provided for @common_login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get common_login;

  /// No description provided for @common_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get common_back;

  /// No description provided for @common_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get common_next;

  /// No description provided for @common_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_cancel;

  /// No description provided for @common_ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get common_ok;

  /// No description provided for @common_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get common_add;

  /// No description provided for @common_finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get common_finish;

  /// No description provided for @common_copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get common_copy;

  /// No description provided for @common_paste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get common_paste;

  /// No description provided for @common_upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get common_upload;

  /// No description provided for @common_random.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get common_random;

  /// No description provided for @common_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get common_all;

  /// No description provided for @common_buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get common_buy;

  /// No description provided for @common_sell.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get common_sell;

  /// No description provided for @common_send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get common_send;

  /// No description provided for @common_register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get common_register;

  /// No description provided for @form_inputNickname.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get form_inputNickname;

  /// No description provided for @form_inputInviteCode.
  ///
  /// In en, this message translates to:
  /// **'Invite Code(Optional)'**
  String get form_inputInviteCode;

  /// No description provided for @form_enterEmailInstruction.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'ll send you a verification code'**
  String get form_enterEmailInstruction;

  /// No description provided for @form_enterNicknameInstruction.
  ///
  /// In en, this message translates to:
  /// **'Enter the invite code to get power bonus and indirect reward activation'**
  String get form_enterNicknameInstruction;

  /// No description provided for @form_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get form_email;

  /// No description provided for @form_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get form_password;

  /// No description provided for @form_nickname.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get form_nickname;

  /// No description provided for @from_walletPassword.
  ///
  /// In en, this message translates to:
  /// **'Wallet Password'**
  String get from_walletPassword;

  /// No description provided for @form_confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get form_confirmPassword;

  /// No description provided for @form_newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get form_newPassword;

  /// No description provided for @form_address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get form_address;

  /// No description provided for @form_amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get form_amount;

  /// No description provided for @form_balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get form_balance;

  /// No description provided for @form_inputAmount.
  ///
  /// In en, this message translates to:
  /// **'Input amount'**
  String get form_inputAmount;

  /// No description provided for @form_inputCorrectAddress.
  ///
  /// In en, this message translates to:
  /// **'Input correct address'**
  String get form_inputCorrectAddress;

  /// No description provided for @form_inputCorrectAmount.
  ///
  /// In en, this message translates to:
  /// **'Input correct amount'**
  String get form_inputCorrectAmount;

  /// No description provided for @form_enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get form_enterPassword;

  /// No description provided for @form_enter6DigitCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6 digit code'**
  String get form_enter6DigitCode;

  /// No description provided for @form_enterTokenContract.
  ///
  /// In en, this message translates to:
  /// **'Enter the token contract to be added'**
  String get form_enterTokenContract;

  /// No description provided for @form_intelXGroupNameHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter group name'**
  String get form_intelXGroupNameHint;

  /// No description provided for @form_intelXGroupInputUsername.
  ///
  /// In en, this message translates to:
  /// **'Please enter the X username to monitor'**
  String get form_intelXGroupInputUsername;

  /// No description provided for @form_intelXGroupUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter username'**
  String get form_intelXGroupUsernameHint;

  /// No description provided for @validation_emailEmpty.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be empty'**
  String get validation_emailEmpty;

  /// No description provided for @validation_emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get validation_emailInvalid;

  /// No description provided for @validation_emailNotRegistered.
  ///
  /// In en, this message translates to:
  /// **'The email address you entered is not yet registered :)'**
  String get validation_emailNotRegistered;

  /// No description provided for @validation_emailExists.
  ///
  /// In en, this message translates to:
  /// **'Email already exists'**
  String get validation_emailExists;

  /// No description provided for @validation_nicknameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nickname cannot be empty'**
  String get validation_nicknameEmpty;

  /// No description provided for @validation_paymentPinInvalid.
  ///
  /// In en, this message translates to:
  /// **'Payment password format is incorrect'**
  String get validation_paymentPinInvalid;

  /// No description provided for @validation_passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get validation_passwordTooShort;

  /// No description provided for @validation_passwordTooSimple.
  ///
  /// In en, this message translates to:
  /// **'Password must contain uppercase, lowercase, numbers and special characters'**
  String get validation_passwordTooSimple;

  /// No description provided for @validation_passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validation_passwordsDoNotMatch;

  /// No description provided for @validation_passwordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty'**
  String get validation_passwordEmpty;

  /// No description provided for @validation_confirmPasswordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Confirm password cannot be empty'**
  String get validation_confirmPasswordEmpty;

  /// No description provided for @validation_addressInvalid.
  ///
  /// In en, this message translates to:
  /// **'Address format is incorrect'**
  String get validation_addressInvalid;

  /// No description provided for @validation_amountInsufficient.
  ///
  /// In en, this message translates to:
  /// **'Amount is insufficient'**
  String get validation_amountInsufficient;

  /// No description provided for @validation_intelXGroupEmpty.
  ///
  /// In en, this message translates to:
  /// **'Group name cannot be empty'**
  String get validation_intelXGroupEmpty;

  /// No description provided for @validation_verificationCodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'Verification code is invalid'**
  String get validation_verificationCodeInvalid;

  /// No description provided for @validation_inviteCodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'The invite code you entered is incorrect, please check'**
  String get validation_inviteCodeInvalid;

  /// No description provided for @branding_cryptoAiFriend.
  ///
  /// In en, this message translates to:
  /// **'Your Crypto AI Friend'**
  String get branding_cryptoAiFriend;

  /// No description provided for @branding_createYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Your Account'**
  String get branding_createYourAccount;

  /// No description provided for @branding_createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create new account'**
  String get branding_createNewAccount;

  /// No description provided for @branding_createWallet.
  ///
  /// In en, this message translates to:
  /// **'Create Wallet'**
  String get branding_createWallet;

  /// No description provided for @branding_createWalletDescription.
  ///
  /// In en, this message translates to:
  /// **'Click to create a wallet, start your wealth journey'**
  String get branding_createWalletDescription;

  /// No description provided for @terms_termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get terms_termsOfService;

  /// No description provided for @terms_privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get terms_privacy;

  /// No description provided for @terms_cookieNotice.
  ///
  /// In en, this message translates to:
  /// **'Cookie. Take a look at Your Privacy at a Glance.'**
  String get terms_cookieNotice;

  /// No description provided for @terms_acceptTerms.
  ///
  /// In en, this message translates to:
  /// **'By signing up, you accept Dogex\'s '**
  String get terms_acceptTerms;

  /// No description provided for @terms_acknowledgePrivacy.
  ///
  /// In en, this message translates to:
  /// **'you acknowledge that you have read our '**
  String get terms_acknowledgePrivacy;

  /// No description provided for @authFlow_forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get authFlow_forgotPassword;

  /// No description provided for @authFlow_sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get authFlow_sendCode;

  /// No description provided for @authFlow_resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get authFlow_resendCode;

  /// No description provided for @authFlow_continueText.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get authFlow_continueText;

  /// No description provided for @authFlow_updateYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Update your password'**
  String get authFlow_updateYourPassword;

  /// No description provided for @authFlow_saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get authFlow_saveChanges;

  /// No description provided for @authFlow_congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations, the password reset is successful'**
  String get authFlow_congratulations;

  /// No description provided for @authFlow_goToLogin.
  ///
  /// In en, this message translates to:
  /// **'Go to log in'**
  String get authFlow_goToLogin;

  /// No description provided for @authFlow_uploadProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Upload your profile picture'**
  String get authFlow_uploadProfilePicture;

  /// No description provided for @authMessages_verificationFailed.
  ///
  /// In en, this message translates to:
  /// **'Verification code sending failed'**
  String get authMessages_verificationFailed;

  /// No description provided for @authMessages_registrationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful'**
  String get authMessages_registrationSuccess;

  /// No description provided for @authMessages_loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get authMessages_loginSuccess;

  /// No description provided for @authMessages_pleaseLoginFirst.
  ///
  /// In en, this message translates to:
  /// **'Please login first'**
  String get authMessages_pleaseLoginFirst;

  /// No description provided for @authMessages_loginFirst.
  ///
  /// In en, this message translates to:
  /// **'Please login first'**
  String get authMessages_loginFirst;

  /// No description provided for @authMessages_addSuccess.
  ///
  /// In en, this message translates to:
  /// **'Add success!'**
  String get authMessages_addSuccess;

  /// No description provided for @wallet_noToken.
  ///
  /// In en, this message translates to:
  /// **'No tokens yet, click Add Tokens'**
  String get wallet_noToken;

  /// No description provided for @wallet_managementWallet.
  ///
  /// In en, this message translates to:
  /// **'Management Wallet'**
  String get wallet_managementWallet;

  /// No description provided for @wallet_addAccount.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get wallet_addAccount;

  /// No description provided for @wallet_hideSmallAssets.
  ///
  /// In en, this message translates to:
  /// **'Hide small assets'**
  String get wallet_hideSmallAssets;

  /// No description provided for @wallet_totalAssetEstimation.
  ///
  /// In en, this message translates to:
  /// **'Total Asset Estimation'**
  String get wallet_totalAssetEstimation;

  /// No description provided for @wallet_transferIn.
  ///
  /// In en, this message translates to:
  /// **'Receive'**
  String get wallet_transferIn;

  /// No description provided for @wallet_transferOut.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get wallet_transferOut;

  /// No description provided for @wallet_transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get wallet_transfer;

  /// No description provided for @wallet_selectToken.
  ///
  /// In en, this message translates to:
  /// **'Select token'**
  String get wallet_selectToken;

  /// No description provided for @wallet_selectNetwork.
  ///
  /// In en, this message translates to:
  /// **'Select Network'**
  String get wallet_selectNetwork;

  /// No description provided for @wallet_network.
  ///
  /// In en, this message translates to:
  /// **'Network: {networkName}'**
  String wallet_network(Object networkName);

  /// No description provided for @wallet_receivingAddress.
  ///
  /// In en, this message translates to:
  /// **'Receiving address'**
  String get wallet_receivingAddress;

  /// No description provided for @wallet_available.
  ///
  /// In en, this message translates to:
  /// **'Available: {amount} {token}'**
  String wallet_available(Object amount, Object token);

  /// No description provided for @wallet_gasFee.
  ///
  /// In en, this message translates to:
  /// **'Gas Fee'**
  String get wallet_gasFee;

  /// No description provided for @wallet_gasFeeInsufficient.
  ///
  /// In en, this message translates to:
  /// **'Gas Fee is insufficient, please add enough Gas and try again'**
  String get wallet_gasFeeInsufficient;

  /// No description provided for @wallet_networkFees.
  ///
  /// In en, this message translates to:
  /// **'Network Fees'**
  String get wallet_networkFees;

  /// No description provided for @wallet_defaultGroup.
  ///
  /// In en, this message translates to:
  /// **'Default Group'**
  String get wallet_defaultGroup;

  /// No description provided for @tokens_couldNotFindToken.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t find your token?'**
  String get tokens_couldNotFindToken;

  /// No description provided for @tokens_tapToAddToken.
  ///
  /// In en, this message translates to:
  /// **'Tap the button below to add.'**
  String get tokens_tapToAddToken;

  /// No description provided for @tokens_addToken.
  ///
  /// In en, this message translates to:
  /// **'+ Add a token'**
  String get tokens_addToken;

  /// No description provided for @tokens_contractAddressError.
  ///
  /// In en, this message translates to:
  /// **'Can\'t find tokens for this contract address, you may have entered it incorrectly, please check and try again.'**
  String get tokens_contractAddressError;

  /// No description provided for @tokens_addTokenNow.
  ///
  /// In en, this message translates to:
  /// **'Add the token now?'**
  String get tokens_addTokenNow;

  /// No description provided for @tokens_selectMainnet.
  ///
  /// In en, this message translates to:
  /// **'Select a mainnet'**
  String get tokens_selectMainnet;

  /// No description provided for @transfer_sendToken.
  ///
  /// In en, this message translates to:
  /// **'Send token'**
  String get transfer_sendToken;

  /// No description provided for @transfer_confirmAgain.
  ///
  /// In en, this message translates to:
  /// **'Confirm Again'**
  String get transfer_confirmAgain;

  /// No description provided for @transfer_sendTokenPadding1.
  ///
  /// In en, this message translates to:
  /// **'The transaction has been submitted.'**
  String get transfer_sendTokenPadding1;

  /// No description provided for @transfer_sendTokenPadding2.
  ///
  /// In en, this message translates to:
  /// **'Please be patient.'**
  String get transfer_sendTokenPadding2;

  /// No description provided for @transfer_sendTokenPadding3.
  ///
  /// In en, this message translates to:
  /// **'1234.23B FLAPDOGE'**
  String get transfer_sendTokenPadding3;

  /// No description provided for @transfer_sendTokenPadding4.
  ///
  /// In en, this message translates to:
  /// **'have been sent'**
  String get transfer_sendTokenPadding4;

  /// No description provided for @transfer_sendTokenPadding5.
  ///
  /// In en, this message translates to:
  /// **'Go to the browser to view'**
  String get transfer_sendTokenPadding5;

  /// No description provided for @transfer_failedToSendToken.
  ///
  /// In en, this message translates to:
  /// **'Failed to send token'**
  String get transfer_failedToSendToken;

  /// No description provided for @transfer_failedToSendTokenReason.
  ///
  /// In en, this message translates to:
  /// **'Error reason: Gas or balance is insufficient'**
  String get transfer_failedToSendTokenReason;

  /// No description provided for @transfer_failedToSendTokenReason2.
  ///
  /// In en, this message translates to:
  /// **'Or the password is incorrect'**
  String get transfer_failedToSendTokenReason2;

  /// No description provided for @intel_intelSearch.
  ///
  /// In en, this message translates to:
  /// **'Search and discover top memecoin'**
  String get intel_intelSearch;

  /// No description provided for @intel_intelPaste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get intel_intelPaste;

  /// No description provided for @intel_followMoreIntel.
  ///
  /// In en, this message translates to:
  /// **'Follow More Intel'**
  String get intel_followMoreIntel;

  /// No description provided for @intel_intelAiAgent.
  ///
  /// In en, this message translates to:
  /// **'Intel AI Agent'**
  String get intel_intelAiAgent;

  /// No description provided for @intel_smartWalletTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart Money Detective'**
  String get intel_smartWalletTitle;

  /// No description provided for @intel_smartWalletDesc.
  ///
  /// In en, this message translates to:
  /// **'Aggregate 20k smart money, real-time updates, support adding custom addresses and AI Agent auto trading'**
  String get intel_smartWalletDesc;

  /// No description provided for @intel_xTitle.
  ///
  /// In en, this message translates to:
  /// **'Twitter Scout'**
  String get intel_xTitle;

  /// No description provided for @intel_xDesc.
  ///
  /// In en, this message translates to:
  /// **'1s sync, timely capture wealth opportunities from comments by Musk, CZ, Vitalik and other celebrities'**
  String get intel_xDesc;

  /// No description provided for @intel_telegramTitle.
  ///
  /// In en, this message translates to:
  /// **'Telegram Messenger'**
  String get intel_telegramTitle;

  /// No description provided for @intel_telegramDesc.
  ///
  /// In en, this message translates to:
  /// **'1s sync, summarize investment wisdom from major cryptocurrency channels on Telegram'**
  String get intel_telegramDesc;

  /// No description provided for @intel_newCoinTitle.
  ///
  /// In en, this message translates to:
  /// **'New Coin Sentinel'**
  String get intel_newCoinTitle;

  /// No description provided for @intel_newCoinDesc.
  ///
  /// In en, this message translates to:
  /// **'10000x wealth code often comes from newly emerged tokens, support multi-dimensional, multi-chain filtering'**
  String get intel_newCoinDesc;

  /// No description provided for @intelGroups_intelXGroupTitle.
  ///
  /// In en, this message translates to:
  /// **'Twitter Scout: Groups'**
  String get intelGroups_intelXGroupTitle;

  /// No description provided for @intelGroups_intelXGroupAdd.
  ///
  /// In en, this message translates to:
  /// **'Add Group'**
  String get intelGroups_intelXGroupAdd;

  /// No description provided for @intelGroups_intelXGroupEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Group'**
  String get intelGroups_intelXGroupEdit;

  /// No description provided for @intelGroups_intelXGroupTip1.
  ///
  /// In en, this message translates to:
  /// **'You can add multiple groups'**
  String get intelGroups_intelXGroupTip1;

  /// No description provided for @intelGroups_intelXGroupTip2.
  ///
  /// In en, this message translates to:
  /// **'Each group uses different notification and AI trading strategies'**
  String get intelGroups_intelXGroupTip2;

  /// No description provided for @intelGroups_intelXGroupNotifyTitle.
  ///
  /// In en, this message translates to:
  /// **'Hey {name}, how would you like me to notify you about this group?'**
  String intelGroups_intelXGroupNotifyTitle(Object name);

  /// No description provided for @intelGroups_intelXGroupNotifyDesc.
  ///
  /// In en, this message translates to:
  /// **'You have set up AI Agent auto-trading, don\'t worry, I will try my best to help you make money :)'**
  String get intelGroups_intelXGroupNotifyDesc;

  /// No description provided for @intelGroups_intelXGroupNotifyAll.
  ///
  /// In en, this message translates to:
  /// **'Notify all'**
  String get intelGroups_intelXGroupNotifyAll;

  /// No description provided for @intelGroups_intelXGroupNotifyImportant.
  ///
  /// In en, this message translates to:
  /// **'Notify important'**
  String get intelGroups_intelXGroupNotifyImportant;

  /// No description provided for @intelGroups_intelXGroupMonitorList.
  ///
  /// In en, this message translates to:
  /// **'Monitor List ({count})'**
  String intelGroups_intelXGroupMonitorList(Object count);

  /// No description provided for @intelGroups_intelXGroupWatch.
  ///
  /// In en, this message translates to:
  /// **'Watch'**
  String get intelGroups_intelXGroupWatch;

  /// No description provided for @intelGroups_intelXGroupAddMonitor.
  ///
  /// In en, this message translates to:
  /// **'Add Monitor'**
  String get intelGroups_intelXGroupAddMonitor;

  /// No description provided for @intelGroups_intelXGroupSetTrade.
  ///
  /// In en, this message translates to:
  /// **'Set AI Trade'**
  String get intelGroups_intelXGroupSetTrade;

  /// No description provided for @intelGroups_intelXGroupCryptoKol.
  ///
  /// In en, this message translates to:
  /// **'Crypto KOL'**
  String get intelGroups_intelXGroupCryptoKol;

  /// No description provided for @intelGroups_intelXGroupAccountInfo.
  ///
  /// In en, this message translates to:
  /// **'{count} accounts created by @{username}'**
  String intelGroups_intelXGroupAccountInfo(Object count, Object username);

  /// No description provided for @intelGroups_intelXGroupCopyAiStrategy.
  ///
  /// In en, this message translates to:
  /// **'Copy AI Strategy'**
  String get intelGroups_intelXGroupCopyAiStrategy;

  /// No description provided for @intelGroups_intelXGroupMonitorAll.
  ///
  /// In en, this message translates to:
  /// **'+Monitor All'**
  String get intelGroups_intelXGroupMonitorAll;

  /// No description provided for @intelGroups_intelXGroupCustomMonitor.
  ///
  /// In en, this message translates to:
  /// **'Custom Monitor'**
  String get intelGroups_intelXGroupCustomMonitor;

  /// No description provided for @intelGroups_intelXGroupConfirmAdd.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get intelGroups_intelXGroupConfirmAdd;

  /// No description provided for @monitor_monitorNotEnabled.
  ///
  /// In en, this message translates to:
  /// **'Monitor Not Enabled'**
  String get monitor_monitorNotEnabled;

  /// No description provided for @monitor_monitorEnabled.
  ///
  /// In en, this message translates to:
  /// **'My Monitor: '**
  String get monitor_monitorEnabled;

  /// No description provided for @monitor_aiAgentNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'AI Agent Auto Trading Not Configured'**
  String get monitor_aiAgentNotConfigured;

  /// No description provided for @market_trade.
  ///
  /// In en, this message translates to:
  /// **'Trade'**
  String get market_trade;

  /// No description provided for @market_investmentOpportunities.
  ///
  /// In en, this message translates to:
  /// **'Investment Opportunities'**
  String get market_investmentOpportunities;

  /// No description provided for @market_investmentOpportunitiesDesc.
  ///
  /// In en, this message translates to:
  /// **'View another {count} investment opportunities'**
  String market_investmentOpportunitiesDesc(Object count);

  /// No description provided for @market_investmentOpportunitiesDesc2.
  ///
  /// In en, this message translates to:
  /// **'Collapse'**
  String get market_investmentOpportunitiesDesc2;

  /// No description provided for @market_slippage.
  ///
  /// In en, this message translates to:
  /// **'{slippage}% Slippage'**
  String market_slippage(Object slippage);

  /// No description provided for @market_marketCap.
  ///
  /// In en, this message translates to:
  /// **'Market Cap'**
  String get market_marketCap;

  /// No description provided for @market_risk.
  ///
  /// In en, this message translates to:
  /// **'Risk'**
  String get market_risk;

  /// No description provided for @market_sourceLink.
  ///
  /// In en, this message translates to:
  /// **'Source Link'**
  String get market_sourceLink;

  /// No description provided for @ui_searchAndAdd.
  ///
  /// In en, this message translates to:
  /// **'Search & Add'**
  String get ui_searchAndAdd;

  /// No description provided for @ui_invite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get ui_invite;

  /// No description provided for @ui_receiveAddress.
  ///
  /// In en, this message translates to:
  /// **'Receive Address'**
  String get ui_receiveAddress;

  /// No description provided for @ui_yourAddress.
  ///
  /// In en, this message translates to:
  /// **'Your {networkName} Address'**
  String ui_yourAddress(Object networkName);

  /// No description provided for @ui_addressWarning.
  ///
  /// In en, this message translates to:
  /// **'This address can only be used to receive compatible tokens.'**
  String get ui_addressWarning;

  /// No description provided for @ui_and.
  ///
  /// In en, this message translates to:
  /// **', and'**
  String get ui_and;

  /// No description provided for @ui_noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get ui_noData;

  /// No description provided for @ui_copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get ui_copied;

  /// No description provided for @ui_newMessage.
  ///
  /// In en, this message translates to:
  /// **'There are {count} new messages'**
  String ui_newMessage(Object count);

  /// No description provided for @errors_timeout.
  ///
  /// In en, this message translates to:
  /// **'Timeout, please check your network status and try again'**
  String get errors_timeout;

  /// No description provided for @errors_unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error, please try again later'**
  String get errors_unknownError;

  /// No description provided for @wallet_passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get wallet_passwordHint;

  /// No description provided for @common_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get common_confirm;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Operation failed'**
  String get error;

  /// No description provided for @tokenName.
  ///
  /// In en, this message translates to:
  /// **'Token name'**
  String get tokenName;

  /// No description provided for @intel.
  ///
  /// In en, this message translates to:
  /// **'Intel'**
  String get intel;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @invite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get invite;

  /// No description provided for @trending.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get trending;

  /// No description provided for @trade.
  ///
  /// In en, this message translates to:
  /// **'Trade'**
  String get trade;

  /// No description provided for @newIntel.
  ///
  /// In en, this message translates to:
  /// **'{count} new intel'**
  String newIntel(Object count);

  /// No description provided for @expand.
  ///
  /// In en, this message translates to:
  /// **'Expand'**
  String get expand;

  /// No description provided for @collapse.
  ///
  /// In en, this message translates to:
  /// **'Collapse'**
  String get collapse;

  /// No description provided for @imageLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Image load failed!'**
  String get imageLoadFailed;

  /// No description provided for @eventHunter.
  ///
  /// In en, this message translates to:
  /// **'Event Hunter'**
  String get eventHunter;

  /// No description provided for @noMoreData.
  ///
  /// In en, this message translates to:
  /// **'No more data'**
  String get noMoreData;

  /// No description provided for @buyIn.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buyIn;

  /// No description provided for @sellOut.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get sellOut;

  /// No description provided for @warningHighestIncreaseRate.
  ///
  /// In en, this message translates to:
  /// **'Max Pump'**
  String get warningHighestIncreaseRate;

  /// No description provided for @warningHighestProfit.
  ///
  /// In en, this message translates to:
  /// **'Max Profit'**
  String get warningHighestProfit;

  /// No description provided for @maxWarningHighestIncreaseRate.
  ///
  /// In en, this message translates to:
  /// **'Max pump After Alert'**
  String get maxWarningHighestIncreaseRate;

  /// No description provided for @maxWarningHighestProfit.
  ///
  /// In en, this message translates to:
  /// **'Max profit After Alert'**
  String get maxWarningHighestProfit;

  /// No description provided for @warningMarketCap.
  ///
  /// In en, this message translates to:
  /// **'MCap at Alert'**
  String get warningMarketCap;

  /// No description provided for @currentMarketCap.
  ///
  /// In en, this message translates to:
  /// **'Current MCap'**
  String get currentMarketCap;

  /// No description provided for @videoInitializationFailed.
  ///
  /// In en, this message translates to:
  /// **'Video init failed'**
  String get videoInitializationFailed;

  /// No description provided for @latestDiscoveries.
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get latestDiscoveries;

  /// No description provided for @selectSellToken.
  ///
  /// In en, this message translates to:
  /// **'Sell Token'**
  String get selectSellToken;

  /// No description provided for @selectReceiveToken.
  ///
  /// In en, this message translates to:
  /// **'Receive Token'**
  String get selectReceiveToken;

  /// No description provided for @selectToken.
  ///
  /// In en, this message translates to:
  /// **'Select token'**
  String get selectToken;

  /// No description provided for @tradeNow.
  ///
  /// In en, this message translates to:
  /// **'Trade Now'**
  String get tradeNow;

  /// No description provided for @fastMode.
  ///
  /// In en, this message translates to:
  /// **'Fast Mode'**
  String get fastMode;

  /// No description provided for @normalMode.
  ///
  /// In en, this message translates to:
  /// **'Normal Mode'**
  String get normalMode;

  /// No description provided for @customMode.
  ///
  /// In en, this message translates to:
  /// **'Custom Mode'**
  String get customMode;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @noToken.
  ///
  /// In en, this message translates to:
  /// **'No token'**
  String get noToken;

  /// No description provided for @common_viewTransactionDetails.
  ///
  /// In en, this message translates to:
  /// **'View transaction details'**
  String get common_viewTransactionDetails;

  /// No description provided for @tradeFailedAgain.
  ///
  /// In en, this message translates to:
  /// **'Trade failed. Try again'**
  String get tradeFailedAgain;

  /// No description provided for @transactionFailed.
  ///
  /// In en, this message translates to:
  /// **'Trade failed. Try again'**
  String get transactionFailed;

  /// No description provided for @transactionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Trade success'**
  String get transactionSuccess;

  /// No description provided for @transactionTraing.
  ///
  /// In en, this message translates to:
  /// **'Trade in progress...'**
  String get transactionTraing;

  /// No description provided for @copySuccess.
  ///
  /// In en, this message translates to:
  /// **'Copy success'**
  String get copySuccess;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @sell.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get sell;

  /// No description provided for @buyNow.
  ///
  /// In en, this message translates to:
  /// **'Buy Now'**
  String get buyNow;

  /// No description provided for @selectTradeToken.
  ///
  /// In en, this message translates to:
  /// **'Choose Trading Token'**
  String get selectTradeToken;

  /// No description provided for @crossChainTrade.
  ///
  /// In en, this message translates to:
  /// **'Cross Chain'**
  String get crossChainTrade;

  /// No description provided for @buyWithOtherToken.
  ///
  /// In en, this message translates to:
  /// **'Pay with any token'**
  String get buyWithOtherToken;

  /// No description provided for @sellNow.
  ///
  /// In en, this message translates to:
  /// **'Sell Now'**
  String get sellNow;

  /// No description provided for @max.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get max;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @balanceNotEnough.
  ///
  /// In en, this message translates to:
  /// **'not enough'**
  String get balanceNotEnough;

  /// No description provided for @balanceNotEnoughHint.
  ///
  /// In en, this message translates to:
  /// **'{token} balance not enough, trade blocked'**
  String balanceNotEnoughHint(Object token);

  /// No description provided for @topUpToken.
  ///
  /// In en, this message translates to:
  /// **'Top up {token}'**
  String topUpToken(Object token);

  /// No description provided for @topUpTokenHint.
  ///
  /// In en, this message translates to:
  /// **'Other token'**
  String get topUpTokenHint;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @intel_worldsFastest.
  ///
  /// In en, this message translates to:
  /// **'The world\'s fastest AI monitoring and analysis'**
  String get intel_worldsFastest;

  /// No description provided for @intel_eventMonitor.
  ///
  /// In en, this message translates to:
  /// **'Event monitor: {time} s'**
  String intel_eventMonitor(Object time);

  /// No description provided for @inte_aiAnalysis.
  ///
  /// In en, this message translates to:
  /// **'AI analysis'**
  String inte_aiAnalysis(Object time);

  /// No description provided for @wallet_safe.
  ///
  /// In en, this message translates to:
  /// **'Bank-level security'**
  String get wallet_safe;

  /// No description provided for @receive.
  ///
  /// In en, this message translates to:
  /// **'Receive'**
  String get receive;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'language'**
  String get language;

  /// No description provided for @joinUs.
  ///
  /// In en, this message translates to:
  /// **'Join us'**
  String get joinUs;

  /// No description provided for @welletSecurity.
  ///
  /// In en, this message translates to:
  /// **'Wallet Security'**
  String get welletSecurity;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Switch language'**
  String get languages;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @learnAIGun.
  ///
  /// In en, this message translates to:
  /// **'Learn AIGun'**
  String get learnAIGun;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @tradeSetting.
  ///
  /// In en, this message translates to:
  /// **'Trade Setting'**
  String get tradeSetting;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @fastModeDesc.
  ///
  /// In en, this message translates to:
  /// **'For volatile, high-stakes trades: AI auto-sets slip & fee to race ahead. Gas slightly higher.'**
  String get fastModeDesc;

  /// No description provided for @normalModeDesc.
  ///
  /// In en, this message translates to:
  /// **'For stable, low-competition trades: medium speed, lower gas.'**
  String get normalModeDesc;

  /// No description provided for @customTrade.
  ///
  /// In en, this message translates to:
  /// **'Custom {chain} trade'**
  String customTrade(Object chain);

  /// No description provided for @customTradeDesc.
  ///
  /// In en, this message translates to:
  /// **'For experienced traders'**
  String get customTradeDesc;

  /// No description provided for @slippage.
  ///
  /// In en, this message translates to:
  /// **'Slippage'**
  String get slippage;

  /// No description provided for @underDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Page under development, please wait!'**
  String get underDevelopment;

  /// No description provided for @auto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get auto;

  /// No description provided for @mevProtect.
  ///
  /// In en, this message translates to:
  /// **'MEV'**
  String get mevProtect;

  /// No description provided for @priorityFee.
  ///
  /// In en, this message translates to:
  /// **'Priority Fee'**
  String get priorityFee;

  /// No description provided for @bribeFee.
  ///
  /// In en, this message translates to:
  /// **'Bribe Fee'**
  String get bribeFee;

  /// No description provided for @wallet_receive.
  ///
  /// In en, this message translates to:
  /// **'Receive'**
  String get wallet_receive;

  /// No description provided for @wallet_send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get wallet_send;

  /// No description provided for @wallet_trade.
  ///
  /// In en, this message translates to:
  /// **'Trade'**
  String get wallet_trade;

  /// No description provided for @wallet_invite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get wallet_invite;

  /// No description provided for @paste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paste;

  /// No description provided for @checkAddress.
  ///
  /// In en, this message translates to:
  /// **'Please check the receiving address carefully'**
  String get checkAddress;

  /// No description provided for @transferAmount.
  ///
  /// In en, this message translates to:
  /// **'Transfer Amount'**
  String get transferAmount;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @gasFee.
  ///
  /// In en, this message translates to:
  /// **'Gas Fee'**
  String get gasFee;

  /// No description provided for @addressError.
  ///
  /// In en, this message translates to:
  /// **'Please enter the correct address'**
  String get addressError;

  /// No description provided for @amountError.
  ///
  /// In en, this message translates to:
  /// **'The input amount is incorrect'**
  String get amountError;

  /// No description provided for @gasFeeInsufficient.
  ///
  /// In en, this message translates to:
  /// **'Gas Fee is insufficient, please add enough Gas and try again'**
  String get gasFeeInsufficient;

  /// No description provided for @inputTransferAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter the correct amount'**
  String get inputTransferAmount;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @networkReceive.
  ///
  /// In en, this message translates to:
  /// **'{networkName} Network Receiving'**
  String networkReceive(Object networkName);

  /// No description provided for @tokenReceive.
  ///
  /// In en, this message translates to:
  /// **'{tokenName} Receiving'**
  String tokenReceive(Object tokenName);

  /// No description provided for @marketTab.
  ///
  /// In en, this message translates to:
  /// **'Market'**
  String get marketTab;

  /// No description provided for @aiTab.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get aiTab;

  /// No description provided for @riskTab.
  ///
  /// In en, this message translates to:
  /// **'Risk'**
  String get riskTab;

  /// No description provided for @myHoldings.
  ///
  /// In en, this message translates to:
  /// **'My Holdings'**
  String get myHoldings;

  /// No description provided for @value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// No description provided for @totalProfit.
  ///
  /// In en, this message translates to:
  /// **'Total Profit'**
  String get totalProfit;

  /// No description provided for @holdings.
  ///
  /// In en, this message translates to:
  /// **'Holdings'**
  String get holdings;

  /// No description provided for @totalChange.
  ///
  /// In en, this message translates to:
  /// **'Total Change'**
  String get totalChange;

  /// No description provided for @shareProfit.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareProfit;

  /// No description provided for @marketCap.
  ///
  /// In en, this message translates to:
  /// **'Market Cap'**
  String get marketCap;

  /// No description provided for @liquidity.
  ///
  /// In en, this message translates to:
  /// **'Liquidity'**
  String get liquidity;

  /// No description provided for @volume24h.
  ///
  /// In en, this message translates to:
  /// **'24h Volume'**
  String get volume24h;

  /// No description provided for @holders.
  ///
  /// In en, this message translates to:
  /// **'Holders'**
  String get holders;

  /// No description provided for @basicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic Info'**
  String get basicInfo;

  /// No description provided for @contractAddress.
  ///
  /// In en, this message translates to:
  /// **'Contract Address'**
  String get contractAddress;

  /// No description provided for @blockchain.
  ///
  /// In en, this message translates to:
  /// **'Blockchain'**
  String get blockchain;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @joinAIGunCommunity.
  ///
  /// In en, this message translates to:
  /// **'Join AIGun Community'**
  String get joinAIGunCommunity;

  /// No description provided for @askQuestions.
  ///
  /// In en, this message translates to:
  /// **'Ask questions, get answers and help'**
  String get askQuestions;

  /// No description provided for @feedbackReward.
  ///
  /// In en, this message translates to:
  /// **'Give feedback and get rewards'**
  String get feedbackReward;

  /// No description provided for @projectUpdates.
  ///
  /// In en, this message translates to:
  /// **'Get first-hand project updates'**
  String get projectUpdates;

  /// No description provided for @followX.
  ///
  /// In en, this message translates to:
  /// **'Follow X'**
  String get followX;

  /// No description provided for @joinGroup.
  ///
  /// In en, this message translates to:
  /// **'Join Group'**
  String get joinGroup;

  /// No description provided for @aiNews.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get aiNews;

  /// No description provided for @aiNarrativeAnalysis.
  ///
  /// In en, this message translates to:
  /// **'AI Narrative Analysis'**
  String get aiNarrativeAnalysis;

  /// No description provided for @tradeTax.
  ///
  /// In en, this message translates to:
  /// **'Trade Tax'**
  String get tradeTax;

  /// No description provided for @buyTax.
  ///
  /// In en, this message translates to:
  /// **'Buy Tax'**
  String get buyTax;

  /// No description provided for @sellTax.
  ///
  /// In en, this message translates to:
  /// **'Sell Tax'**
  String get sellTax;

  /// No description provided for @contractAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Contract Analysis'**
  String get contractAnalysis;

  /// No description provided for @riskItems.
  ///
  /// In en, this message translates to:
  /// **'Risk Items'**
  String get riskItems;

  /// No description provided for @warningItems.
  ///
  /// In en, this message translates to:
  /// **'Warning Items'**
  String get warningItems;

  /// No description provided for @noContractAnalysis.
  ///
  /// In en, this message translates to:
  /// **'No contract analysis available for this token'**
  String get noContractAnalysis;

  /// No description provided for @realTime.
  ///
  /// In en, this message translates to:
  /// **'Real time'**
  String get realTime;

  /// No description provided for @average.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get average;

  /// No description provided for @liveAverage.
  ///
  /// In en, this message translates to:
  /// **'Live average:'**
  String get liveAverage;

  /// No description provided for @follow.
  ///
  /// In en, this message translates to:
  /// **'follow'**
  String get follow;

  /// No description provided for @followed.
  ///
  /// In en, this message translates to:
  /// **'followed'**
  String get followed;

  /// No description provided for @hot.
  ///
  /// In en, this message translates to:
  /// **'Hot'**
  String get hot;

  /// No description provided for @aiAgent.
  ///
  /// In en, this message translates to:
  /// **'AI Agent'**
  String get aiAgent;

  /// No description provided for @tracking.
  ///
  /// In en, this message translates to:
  /// **'Tracking'**
  String get tracking;

  /// No description provided for @topPick.
  ///
  /// In en, this message translates to:
  /// **'Top pick'**
  String get topPick;

  /// No description provided for @kLineLoading.
  ///
  /// In en, this message translates to:
  /// **'K Line Loading...'**
  String get kLineLoading;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SEn();
    case 'zh':
      return SZh();
  }

  throw FlutterError(
      'S.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
