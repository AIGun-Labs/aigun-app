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

  /// No description provided for @auth_form_input_code.
  ///
  /// In en, this message translates to:
  /// **'INPUT CODE'**
  String get auth_form_input_code;

  /// No description provided for @auth_form_signIn.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN'**
  String get auth_form_signIn;

  /// No description provided for @auth_form_signUp.
  ///
  /// In en, this message translates to:
  /// **'SIGN UP'**
  String get auth_form_signUp;

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

  /// No description provided for @auth_success_verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Code has been sent to your email'**
  String get auth_success_verifyCode;

  /// No description provided for @auth_failed_sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code failed'**
  String get auth_failed_sendCode;

  /// No description provided for @auth_failed_verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Code sending failed'**
  String get auth_failed_verifyCode;

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

  /// No description provided for @common_signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get common_signup;

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

  /// No description provided for @common_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get common_retry;

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

  /// No description provided for @form_inputEmail.
  ///
  /// In en, this message translates to:
  /// **'INPUT EMAIL'**
  String get form_inputEmail;

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

  /// No description provided for @form_inputEmailInstruction.
  ///
  /// In en, this message translates to:
  /// **'Please enter the correct email address'**
  String get form_inputEmailInstruction;

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

  /// No description provided for @form_username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get form_username;

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

  /// No description provided for @validation_emailAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'Email is already registered'**
  String get validation_emailAlreadyRegistered;

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

  /// No description provided for @validation_emailNotFound.
  ///
  /// In en, this message translates to:
  /// **'Email not found'**
  String get validation_emailNotFound;

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

  /// No description provided for @validation_passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validation_passwordMismatch;

  /// No description provided for @validation_passwordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty'**
  String get validation_passwordEmpty;

  /// No description provided for @validation_passwordInvalid.
  ///
  /// In en, this message translates to:
  /// **'Password format is incorrect'**
  String get validation_passwordInvalid;

  /// No description provided for @validation_confirmPasswordInvalid.
  ///
  /// In en, this message translates to:
  /// **'Confirm password format is incorrect'**
  String get validation_confirmPasswordInvalid;

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

  /// No description provided for @validation_nicknameInvalid.
  ///
  /// In en, this message translates to:
  /// **'The nickname you entered is incorrect, please check'**
  String get validation_nicknameInvalid;

  /// No description provided for @validation_inviteCodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'The invite code you entered is incorrect, please check'**
  String get validation_inviteCodeInvalid;

  /// No description provided for @branding_dogexTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Web3 Secret Weapon'**
  String get branding_dogexTitle;

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

  /// No description provided for @authFlow_checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get authFlow_checkYourEmail;

  /// No description provided for @authFlow_sendCodeTo.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a 6 digit code to:'**
  String get authFlow_sendCodeTo;

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

  /// No description provided for @authMessages_sendCodeSuccess.
  ///
  /// In en, this message translates to:
  /// **'Send code successfully'**
  String get authMessages_sendCodeSuccess;

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

  /// No description provided for @authMessages_registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get authMessages_registrationFailed;

  /// No description provided for @authMessages_invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get authMessages_invalidCredentials;

  /// No description provided for @authMessages_loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get authMessages_loginSuccess;

  /// No description provided for @authMessages_resetPasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Reset password successful'**
  String get authMessages_resetPasswordSuccess;

  /// No description provided for @authMessages_resetPasswordFailed.
  ///
  /// In en, this message translates to:
  /// **'Reset password failed'**
  String get authMessages_resetPasswordFailed;

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

  /// No description provided for @wallet_wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet_wallet;

  /// No description provided for @wallet_noToken.
  ///
  /// In en, this message translates to:
  /// **'No tokens yet, click Add Tokens'**
  String get wallet_noToken;

  /// No description provided for @wallet_noToken1.
  ///
  /// In en, this message translates to:
  /// **'No tokens yet'**
  String get wallet_noToken1;

  /// No description provided for @wallet_multipleAddressesAvailable.
  ///
  /// In en, this message translates to:
  /// **'Multiple addresses available'**
  String get wallet_multipleAddressesAvailable;

  /// No description provided for @wallet_noAddress.
  ///
  /// In en, this message translates to:
  /// **'No address'**
  String get wallet_noAddress;

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

  /// No description provided for @wallet_gasFeeDetails.
  ///
  /// In en, this message translates to:
  /// **'0.001 ETH(\$3.22)'**
  String get wallet_gasFeeDetails;

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

  /// No description provided for @tokens_tokenName.
  ///
  /// In en, this message translates to:
  /// **'Token name'**
  String get tokens_tokenName;

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

  /// No description provided for @tokens_addTokenTitle.
  ///
  /// In en, this message translates to:
  /// **'Select a mainnet'**
  String get tokens_addTokenTitle;

  /// No description provided for @tokens_addTokenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the token contract to be added'**
  String get tokens_addTokenSubtitle;

  /// No description provided for @tokens_contractAddressError.
  ///
  /// In en, this message translates to:
  /// **'Can\'t find tokens for this contract address, you may have entered it incorrectly, please check and try again.'**
  String get tokens_contractAddressError;

  /// No description provided for @tokens_addTokenNow.
  ///
  /// In en, this message translates to:
  /// **'Add the token now？'**
  String get tokens_addTokenNow;

  /// No description provided for @tokens_selectMainnet.
  ///
  /// In en, this message translates to:
  /// **'Select a mainnet'**
  String get tokens_selectMainnet;

  /// No description provided for @tokens_ethereum.
  ///
  /// In en, this message translates to:
  /// **'Ethereum'**
  String get tokens_ethereum;

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

  /// No description provided for @intel_intelligence.
  ///
  /// In en, this message translates to:
  /// **'Intelligence'**
  String get intel_intelligence;

  /// No description provided for @intel_invite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get intel_invite;

  /// No description provided for @intel_trending.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get intel_trending;

  /// No description provided for @intel_trade.
  ///
  /// In en, this message translates to:
  /// **'Trade'**
  String get intel_trade;

  /// No description provided for @intel_notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get intel_notification;

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

  /// No description provided for @intel_addIntel.
  ///
  /// In en, this message translates to:
  /// **'Add Intel'**
  String get intel_addIntel;

  /// No description provided for @intel_intel.
  ///
  /// In en, this message translates to:
  /// **'Intel'**
  String get intel_intel;

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

  /// No description provided for @intelGroups_intelXGroupConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get intelGroups_intelXGroupConfirm;

  /// No description provided for @intelGroups_intelXGroupCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get intelGroups_intelXGroupCancel;

  /// No description provided for @intelGroups_intelXGroupDefault.
  ///
  /// In en, this message translates to:
  /// **'Default Group'**
  String get intelGroups_intelXGroupDefault;

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

  /// No description provided for @intelGroups_intelXGroupMaxLimit.
  ///
  /// In en, this message translates to:
  /// **'Group limit reached'**
  String get intelGroups_intelXGroupMaxLimit;

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

  /// No description provided for @intelGroups_intelXGroupWatching.
  ///
  /// In en, this message translates to:
  /// **'Watching'**
  String get intelGroups_intelXGroupWatching;

  /// No description provided for @intelGroups_intelXGroupSetTrade.
  ///
  /// In en, this message translates to:
  /// **'Set AI Trade'**
  String get intelGroups_intelXGroupSetTrade;

  /// No description provided for @intelGroups_intelXGroupUnwatch.
  ///
  /// In en, this message translates to:
  /// **'Unwatch'**
  String get intelGroups_intelXGroupUnwatch;

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

  /// No description provided for @intelGroups_intelXGroupMonitorAllAtOnce.
  ///
  /// In en, this message translates to:
  /// **'Monitor All at Once'**
  String get intelGroups_intelXGroupMonitorAllAtOnce;

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

  /// No description provided for @monitor_uaiAutoTrade.
  ///
  /// In en, this message translates to:
  /// **'UAI-AutoTrade'**
  String get monitor_uaiAutoTrade;

  /// No description provided for @market_market.
  ///
  /// In en, this message translates to:
  /// **'Market'**
  String get market_market;

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

  /// No description provided for @ui_userName.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get ui_userName;

  /// No description provided for @ui_notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get ui_notification;

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

  /// No description provided for @ui_copyMessage.
  ///
  /// In en, this message translates to:
  /// **'This address can only be used to receive compatible tokens.'**
  String get ui_copyMessage;

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

  /// No description provided for @errors_networkError.
  ///
  /// In en, this message translates to:
  /// **'Network error, please check your network settings and try again'**
  String get errors_networkError;

  /// No description provided for @errors_timeout.
  ///
  /// In en, this message translates to:
  /// **'Timeout, please check your network status and try again'**
  String get errors_timeout;

  /// No description provided for @errors_serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error, please try again later'**
  String get errors_serverError;

  /// No description provided for @errors_unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error, please try again later'**
  String get errors_unknownError;

  /// No description provided for @wallet_createWallet.
  ///
  /// In en, this message translates to:
  /// **'Create Wallet'**
  String get wallet_createWallet;

  /// No description provided for @wallet_enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter wallet password'**
  String get wallet_enterPassword;

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
