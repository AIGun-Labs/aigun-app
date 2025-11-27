// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'No Noise, Just The Edge';

  @override
  String get auth_form_input_email => 'INPUT EMAIL';

  @override
  String get auth_form_signIn => 'SIGN IN';

  @override
  String get auth_form_signInSignUp => 'SIGN IN/SIGN UP';

  @override
  String get auth_success_sendCode => 'Send code successfully';

  @override
  String get auth_failed_sendCode => 'Send code failed';

  @override
  String get auth_message_checkYourEmail => 'Check Your Email';

  @override
  String get auth_message_weveSendA6DigitCodeTo =>
      'We\'ve Sent A 6 Digit Code To:';

  @override
  String get auth_resendCode => 'Resend Code';

  @override
  String get common_login => 'Log in';

  @override
  String get common_back => 'Back';

  @override
  String get common_next => 'Next';

  @override
  String get common_cancel => 'Cancel';

  @override
  String get common_ok => 'OK';

  @override
  String get common_add => 'Add';

  @override
  String get common_finish => 'Finish';

  @override
  String get common_copy => 'Copy';

  @override
  String get common_paste => 'Paste';

  @override
  String get common_upload => 'Upload';

  @override
  String get common_random => 'Random';

  @override
  String get common_all => 'All';

  @override
  String get common_buy => 'Buy';

  @override
  String get common_sell => 'Sell';

  @override
  String get common_send => 'Send';

  @override
  String get common_register => 'Register';

  @override
  String get form_inputNickname => 'Nickname';

  @override
  String get form_inputInviteCode => 'Invite Code(Optional)';

  @override
  String get form_enterEmailInstruction =>
      'Enter your email and we\'ll send you a verification code';

  @override
  String get form_enterNicknameInstruction =>
      'Enter the invite code to get power bonus and indirect reward activation';

  @override
  String get form_email => 'Email';

  @override
  String get form_password => 'Password';

  @override
  String get form_nickname => 'Nickname';

  @override
  String get from_walletPassword => 'Wallet Password';

  @override
  String get form_confirmPassword => 'Confirm Password';

  @override
  String get form_newPassword => 'New password';

  @override
  String get form_address => 'Address';

  @override
  String get form_amount => 'Amount';

  @override
  String get form_balance => 'Balance';

  @override
  String get form_inputAmount => 'Input amount';

  @override
  String get form_inputCorrectAddress => 'Input correct address';

  @override
  String get form_inputCorrectAmount => 'Input correct amount';

  @override
  String get form_enterPassword => 'Enter Password';

  @override
  String get form_enter6DigitCode => 'Enter the 6 digit code';

  @override
  String get form_enterTokenContract => 'Enter the token contract to be added';

  @override
  String get form_intelXGroupNameHint => 'Please enter group name';

  @override
  String get form_intelXGroupInputUsername =>
      'Please enter the X username to monitor';

  @override
  String get form_intelXGroupUsernameHint => 'Enter username';

  @override
  String get validation_emailEmpty => 'Email cannot be empty';

  @override
  String get validation_emailInvalid => 'Invalid email format';

  @override
  String get validation_emailNotRegistered =>
      'The email address you entered is not yet registered :)';

  @override
  String get validation_emailExists => 'Email already exists';

  @override
  String get validation_nicknameEmpty => 'Nickname cannot be empty';

  @override
  String get validation_paymentPinInvalid =>
      'Payment password format is incorrect';

  @override
  String get validation_passwordTooShort =>
      'Password must be at least 8 characters';

  @override
  String get validation_passwordTooSimple =>
      'Password must contain uppercase, lowercase, numbers and special characters';

  @override
  String get validation_passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get validation_passwordEmpty => 'Password cannot be empty';

  @override
  String get validation_confirmPasswordEmpty =>
      'Confirm password cannot be empty';

  @override
  String get validation_addressInvalid => 'Address format is incorrect';

  @override
  String get validation_amountInsufficient => 'Amount is insufficient';

  @override
  String get validation_intelXGroupEmpty => 'Group name cannot be empty';

  @override
  String get validation_verificationCodeInvalid =>
      'Verification code is invalid';

  @override
  String get validation_inviteCodeInvalid =>
      'The invite code you entered is incorrect, please check';

  @override
  String get branding_cryptoAiFriend => 'Your Crypto AI Friend';

  @override
  String get branding_createYourAccount => 'Create Your Account';

  @override
  String get branding_createNewAccount => 'Create new account';

  @override
  String get branding_createWallet => 'Create Wallet';

  @override
  String get branding_createWalletDescription =>
      'Click to create a wallet, start your wealth journey';

  @override
  String get terms_termsOfService => 'Terms of Service';

  @override
  String get terms_privacy => 'Privacy';

  @override
  String get terms_cookieNotice =>
      'Cookie. Take a look at Your Privacy at a Glance.';

  @override
  String get terms_acceptTerms => 'By signing up, you accept Dogex\'s ';

  @override
  String get terms_acknowledgePrivacy =>
      'you acknowledge that you have read our ';

  @override
  String get authFlow_forgotPassword => 'Forgot Password?';

  @override
  String get authFlow_sendCode => 'Send Code';

  @override
  String get authFlow_resendCode => 'Resend code';

  @override
  String get authFlow_continueText => 'CONTINUE';

  @override
  String get authFlow_updateYourPassword => 'Update your password';

  @override
  String get authFlow_saveChanges => 'Save changes';

  @override
  String get authFlow_congratulations =>
      'Congratulations, the password reset is successful';

  @override
  String get authFlow_goToLogin => 'Go to log in';

  @override
  String get authFlow_uploadProfilePicture => 'Upload your profile picture';

  @override
  String get authMessages_verificationFailed =>
      'Verification code sending failed';

  @override
  String get authMessages_registrationSuccess => 'Registration successful';

  @override
  String get authMessages_loginSuccess => 'Login successful';

  @override
  String get authMessages_pleaseLoginFirst => 'Please login first';

  @override
  String get authMessages_loginFirst => 'Please login first';

  @override
  String get authMessages_addSuccess => 'Add success!';

  @override
  String get wallet_noToken => 'No tokens yet, click Add Tokens';

  @override
  String get wallet_managementWallet => 'Management Wallet';

  @override
  String get wallet_addAccount => 'Add Account';

  @override
  String get wallet_hideSmallAssets => 'Hide small assets';

  @override
  String get wallet_totalAssetEstimation => 'Total Asset Estimation';

  @override
  String get wallet_transferIn => 'Receive';

  @override
  String get wallet_transferOut => 'Send';

  @override
  String get wallet_transfer => 'Transfer';

  @override
  String get wallet_selectToken => 'Select token';

  @override
  String get wallet_selectNetwork => 'Select Network';

  @override
  String wallet_network(Object networkName) {
    return 'Network: $networkName';
  }

  @override
  String get wallet_receivingAddress => 'Receiving address';

  @override
  String wallet_available(Object amount, Object token) {
    return 'Available: $amount $token';
  }

  @override
  String get wallet_gasFee => 'Gas Fee';

  @override
  String get wallet_gasFeeInsufficient =>
      'Gas Fee is insufficient, please add enough Gas and try again';

  @override
  String get wallet_networkFees => 'Network Fees';

  @override
  String get wallet_defaultGroup => 'Default Group';

  @override
  String get tokens_couldNotFindToken => 'Couldn\'t find your token?';

  @override
  String get tokens_tapToAddToken => 'Tap the button below to add.';

  @override
  String get tokens_addToken => '+ Add a token';

  @override
  String get tokens_contractAddressError =>
      'Can\'t find tokens for this contract address, you may have entered it incorrectly, please check and try again.';

  @override
  String get tokens_addTokenNow => 'Add the token now?';

  @override
  String get tokens_selectMainnet => 'Select a mainnet';

  @override
  String get transfer_sendToken => 'Send token';

  @override
  String get transfer_confirmAgain => 'Confirm Again';

  @override
  String get transfer_sendTokenPadding1 =>
      'The transaction has been submitted.';

  @override
  String get transfer_sendTokenPadding2 => 'Please be patient.';

  @override
  String get transfer_sendTokenPadding3 => '1234.23B FLAPDOGE';

  @override
  String get transfer_sendTokenPadding4 => 'have been sent';

  @override
  String get transfer_sendTokenPadding5 => 'Go to the browser to view';

  @override
  String get transfer_failedToSendToken => 'Failed to send token';

  @override
  String get transfer_failedToSendTokenReason =>
      'Error reason: Gas or balance is insufficient';

  @override
  String get transfer_failedToSendTokenReason2 =>
      'Or the password is incorrect';

  @override
  String get intel_intelSearch => 'Search and discover top memecoin';

  @override
  String get intel_intelPaste => 'Paste';

  @override
  String get intel_followMoreIntel => 'Follow More Intel';

  @override
  String get intel_intelAiAgent => 'Intel AI Agent';

  @override
  String get intel_smartWalletTitle => 'Smart Money Detective';

  @override
  String get intel_smartWalletDesc =>
      'Aggregate 20k smart money, real-time updates, support adding custom addresses and AI Agent auto trading';

  @override
  String get intel_xTitle => 'Twitter Scout';

  @override
  String get intel_xDesc =>
      '1s sync, timely capture wealth opportunities from comments by Musk, CZ, Vitalik and other celebrities';

  @override
  String get intel_telegramTitle => 'Telegram Messenger';

  @override
  String get intel_telegramDesc =>
      '1s sync, summarize investment wisdom from major cryptocurrency channels on Telegram';

  @override
  String get intel_newCoinTitle => 'New Coin Sentinel';

  @override
  String get intel_newCoinDesc =>
      '10000x wealth code often comes from newly emerged tokens, support multi-dimensional, multi-chain filtering';

  @override
  String get intelGroups_intelXGroupTitle => 'Twitter Scout: Groups';

  @override
  String get intelGroups_intelXGroupAdd => 'Add Group';

  @override
  String get intelGroups_intelXGroupEdit => 'Edit Group';

  @override
  String get intelGroups_intelXGroupTip1 => 'You can add multiple groups';

  @override
  String get intelGroups_intelXGroupTip2 =>
      'Each group uses different notification and AI trading strategies';

  @override
  String intelGroups_intelXGroupNotifyTitle(Object name) {
    return 'Hey $name, how would you like me to notify you about this group?';
  }

  @override
  String get intelGroups_intelXGroupNotifyDesc =>
      'You have set up AI Agent auto-trading, don\'t worry, I will try my best to help you make money :)';

  @override
  String get intelGroups_intelXGroupNotifyAll => 'Notify all';

  @override
  String get intelGroups_intelXGroupNotifyImportant => 'Notify important';

  @override
  String intelGroups_intelXGroupMonitorList(Object count) {
    return 'Monitor List ($count)';
  }

  @override
  String get intelGroups_intelXGroupWatch => 'Watch';

  @override
  String get intelGroups_intelXGroupAddMonitor => 'Add Monitor';

  @override
  String get intelGroups_intelXGroupSetTrade => 'Set AI Trade';

  @override
  String get intelGroups_intelXGroupCryptoKol => 'Crypto KOL';

  @override
  String intelGroups_intelXGroupAccountInfo(Object count, Object username) {
    return '$count accounts created by @$username';
  }

  @override
  String get intelGroups_intelXGroupCopyAiStrategy => 'Copy AI Strategy';

  @override
  String get intelGroups_intelXGroupMonitorAll => '+Monitor All';

  @override
  String get intelGroups_intelXGroupCustomMonitor => 'Custom Monitor';

  @override
  String get intelGroups_intelXGroupConfirmAdd => 'OK';

  @override
  String get monitor_monitorNotEnabled => 'Monitor Not Enabled';

  @override
  String get monitor_monitorEnabled => 'My Monitor: ';

  @override
  String get monitor_aiAgentNotConfigured =>
      'AI Agent Auto Trading Not Configured';

  @override
  String get market_trade => 'Trade';

  @override
  String get market_investmentOpportunities => 'Investment Opportunities';

  @override
  String market_investmentOpportunitiesDesc(Object count) {
    return 'View another $count investment opportunities';
  }

  @override
  String get market_investmentOpportunitiesDesc2 => 'Collapse';

  @override
  String market_slippage(Object slippage) {
    return '$slippage% Slippage';
  }

  @override
  String get market_marketCap => 'Market Cap';

  @override
  String get market_risk => 'Risk';

  @override
  String get market_sourceLink => 'Source Link';

  @override
  String get ui_searchAndAdd => 'Search & Add';

  @override
  String get ui_invite => 'Invite';

  @override
  String get ui_receiveAddress => 'Receive Address';

  @override
  String ui_yourAddress(Object networkName) {
    return 'Your $networkName Address';
  }

  @override
  String get ui_addressWarning =>
      'This address can only be used to receive compatible tokens.';

  @override
  String get ui_and => ', and';

  @override
  String get ui_noData => 'No data';

  @override
  String get ui_copied => 'Copied';

  @override
  String ui_newMessage(Object count) {
    return 'There are $count new messages';
  }

  @override
  String get errors_timeout =>
      'Timeout, please check your network status and try again';

  @override
  String get errors_unknownError => 'Unknown error, please try again later';

  @override
  String get wallet_passwordHint => 'Enter password';

  @override
  String get common_confirm => 'Confirm';

  @override
  String get logout => 'Logout';

  @override
  String get error => 'Operation failed';

  @override
  String get tokenName => 'Token name';

  @override
  String get intel => 'Intel';

  @override
  String get wallet => 'Wallet';

  @override
  String get invite => 'Invite';

  @override
  String get trending => 'Trending';

  @override
  String get trade => 'Trade';

  @override
  String newIntel(Object count) {
    return '$count new intel';
  }

  @override
  String get expand => 'Expand';

  @override
  String get collapse => 'Collapse';

  @override
  String get imageLoadFailed => 'Image load failed!';

  @override
  String get eventHunter => 'Event Hunter';

  @override
  String get noMoreData => 'There is no more data.';

  @override
  String get buyIn => 'Buy';

  @override
  String get sellOut => 'Sell';

  @override
  String get warningHighestIncreaseRate => 'Max Pump';

  @override
  String get warningHighestProfit => 'Max Profit';

  @override
  String get maxWarningHighestIncreaseRate => 'Max pump After Alert';

  @override
  String get maxWarningHighestProfit => 'Max profit After Alert';

  @override
  String get warningMarketCap => 'MCap at Alert';

  @override
  String get currentMarketCap => 'Current MCap';

  @override
  String get videoInitializationFailed => 'Video init failed';

  @override
  String get playbackSpeed => 'Playback Speed';

  @override
  String get subtitles => 'Subtitles';

  @override
  String get cancel => 'Cancel';

  @override
  String get latestDiscoveries => 'Latest';

  @override
  String get selectSellToken => 'Sell Token';

  @override
  String get selectReceiveToken => 'Receive Token';

  @override
  String get selectToken => 'Select token';

  @override
  String get tradeNow => 'Trade Now';

  @override
  String get fastMode => 'Fast Mode';

  @override
  String get normalMode => 'Normal Mode';

  @override
  String get customMode => 'Custom Mode';

  @override
  String get open => 'Open';

  @override
  String get close => 'Close';

  @override
  String get noToken => 'No token';

  @override
  String get common_viewTransactionDetails => 'View transaction details';

  @override
  String get tradeFailedAgain => 'Trade failed. Try again';

  @override
  String get transactionFailed => 'Trade failed. Try again';

  @override
  String get transactionSuccess => 'Trade success';

  @override
  String get transactionTraing => 'Trade in progress...';

  @override
  String get copySuccess => 'Copy success';

  @override
  String get buy => 'Buy';

  @override
  String get sell => 'Sell';

  @override
  String get buyNow => 'Buy Now';

  @override
  String get selectTradeToken => 'Choose Trading Token';

  @override
  String get crossChainTrade => 'Cross Chain';

  @override
  String get buyWithOtherToken => 'Pay with any token';

  @override
  String get sellNow => 'Sell Now';

  @override
  String get max => 'Max';

  @override
  String get balance => 'Balance';

  @override
  String get balanceNotEnough => 'not enough';

  @override
  String balanceNotEnoughHint(Object token) {
    return '$token balance not enough, trade blocked';
  }

  @override
  String topUpToken(Object token) {
    return 'Top up $token';
  }

  @override
  String get topUpTokenHint => 'Other token';

  @override
  String get all => 'All';

  @override
  String get intel_worldsFastest =>
      'The world\'s fastest AI monitoring and analysis';

  @override
  String intel_eventMonitor(Object time) {
    return 'Event monitor: $time s';
  }

  @override
  String intel_aiAnalysis(Object time) {
    return 'AI analysis $time s';
  }

  @override
  String get wallet_safe => 'Bank-level security';

  @override
  String get receive => 'Receive';

  @override
  String get send => 'Send';

  @override
  String get language => 'language';

  @override
  String get joinUs => 'Join us';

  @override
  String get welletSecurity => 'Wallet Security';

  @override
  String get languages => 'Switch language';

  @override
  String get update => 'Update';

  @override
  String get learnAIGun => 'Learn AIGun';

  @override
  String get logOut => 'Log out';

  @override
  String get tradeSetting => 'Trade Setting';

  @override
  String get reset => 'Reset';

  @override
  String get fastModeDesc =>
      'For volatile, high-stakes trades: AI auto-sets slip & fee to race ahead. Gas slightly higher.';

  @override
  String get normalModeDesc =>
      'For stable, low-competition trades: medium speed, lower gas.';

  @override
  String customTrade(Object chain) {
    return 'Custom $chain trade';
  }

  @override
  String get customTradeDesc => 'For experienced traders';

  @override
  String get slippage => 'Slippage';

  @override
  String get underDevelopment => 'Page under development, please wait!';

  @override
  String get auto => 'Auto';

  @override
  String get mevProtect => 'MEV';

  @override
  String get priorityFee => 'Priority Fee';

  @override
  String get bribeFee => 'Bribe Fee';

  @override
  String get wallet_receive => 'Receive';

  @override
  String get wallet_send => 'Send';

  @override
  String get wallet_trade => 'Trade';

  @override
  String get wallet_invite => 'Invite';

  @override
  String get paste => 'Paste';

  @override
  String get checkAddress => 'Please check the receiving address carefully';

  @override
  String get transferAmount => 'Transfer Amount';

  @override
  String get available => 'Available';

  @override
  String get gasFee => 'Gas Fee';

  @override
  String get addressError => 'Please enter the correct address';

  @override
  String get amountError => 'The input amount is incorrect';

  @override
  String get gasFeeInsufficient =>
      'Gas Fee is insufficient, please add enough Gas and try again';

  @override
  String get inputTransferAmount => 'Please enter the correct amount';

  @override
  String get copy => 'Copy';

  @override
  String networkReceive(Object networkName) {
    return '$networkName Network';
  }

  @override
  String tokenReceive(Object tokenName) {
    return '$tokenName Receiving';
  }

  @override
  String get marketTab => 'Market';

  @override
  String get aiTab => 'AI';

  @override
  String get riskTab => 'Risk';

  @override
  String get myHoldings => 'My Holdings';

  @override
  String get value => 'Value';

  @override
  String get totalProfit => 'Total Profit';

  @override
  String get holdings => 'Holdings';

  @override
  String get totalChange => 'Total Change';

  @override
  String get shareProfit => 'Share';

  @override
  String get marketCap => 'Market Cap';

  @override
  String get liquidity => 'Liquidity';

  @override
  String get volume24h => '24h Volume';

  @override
  String get holders => 'Holders';

  @override
  String get basicInfo => 'Basic Info';

  @override
  String get contractAddress => 'Contract Address';

  @override
  String get blockchain => 'Blockchain';

  @override
  String get copied => 'Copied';

  @override
  String get joinAIGunCommunity => 'Join AIGun Community';

  @override
  String get askQuestions => 'Ask questions, get answers and help';

  @override
  String get feedbackReward => 'Give feedback and get rewards';

  @override
  String get projectUpdates => 'Get first-hand project updates';

  @override
  String get followX => 'Follow X';

  @override
  String get joinGroup => 'Join Group';

  @override
  String get aiNews => 'AI';

  @override
  String get aiNarrativeAnalysis => 'AI Narrative Analysis';

  @override
  String get tradeTax => 'Trade Tax';

  @override
  String get buyTax => 'Buy Tax';

  @override
  String get sellTax => 'Sell Tax';

  @override
  String get contractAnalysis => 'Contract Analysis';

  @override
  String get riskItems => 'Risk Items';

  @override
  String get warningItems => 'Warning Items';

  @override
  String get noContractAnalysis =>
      'No contract analysis available for this token';

  @override
  String get realTime => 'Real time';

  @override
  String get average => 'Average';

  @override
  String get liveAverage => 'Live average:';

  @override
  String get follow => 'follow';

  @override
  String get followed => 'followed';

  @override
  String get hot => 'Hot';

  @override
  String get aiAgent => 'AI Agent';

  @override
  String get tracking => 'Tracking';

  @override
  String get topPick => 'Top pick';

  @override
  String get candlestickLoading => 'Candlestick Loading...';

  @override
  String get userNotExist => 'User not exist, please register';

  @override
  String get userExist => 'User already exists';

  @override
  String get verifyCodeExpired => 'Verification code expired';

  @override
  String get verifyCodeInvalidFormat => 'Verification code format error';

  @override
  String get verifyCodeFail => 'The verification code you entered is incorrect';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get registerSuccess => 'Register success';

  @override
  String get nicknameInvalid => 'Nickname format error';

  @override
  String get inviteCodeInvalid => 'Invite code error';

  @override
  String get paymentPinInvalid => 'Payment password format error';

  @override
  String get createWalletFail => 'Create wallet fail';

  @override
  String get walletUserExist => 'Wallet user already exists';

  @override
  String get walletPinInvalid => 'Wallet password format error';

  @override
  String get cancelTracking => 'Cancel tracking';

  @override
  String get noData => 'No Data';

  @override
  String get development => 'In Development ...';

  @override
  String get followSuccess => 'Successfully';

  @override
  String get searchToken => 'Search name or contract address';

  @override
  String get searchNameOrCA => 'Search name or CA';

  @override
  String get searching => 'Searching';

  @override
  String get noTokenFound => 'No token found\nPlease check and try again';

  @override
  String tokenNotTrading(Object tokenName) {
    return '$tokenName is not trading yet, please stay tuned';
  }

  @override
  String get relatedToken => 'Related Tokens';

  @override
  String get noNewVersion => 'Already the latest version';

  @override
  String checkUpdateFail(Object message) {
    return 'Check update failed: $message';
  }

  @override
  String get downloading => 'downloading...';

  @override
  String get newVersionUpgrade => 'New Version Upgrade';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get skip => 'Skip';

  @override
  String get updateNotice => 'Update Notice';

  @override
  String get updateNoticeDesc =>
      'To update the AIGun App normally, please go to your phone Settings -> Unknown Source,and allow AIGun under it. This will only give permission for AIGun app updates.';

  @override
  String get settings => 'Settings';

  @override
  String get tips => 'Tips';

  @override
  String get ben => 'This';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get privacyPolicyDesc =>
      'We explain how we process your personal information and your related rights. Please read carefully before using.';

  @override
  String get privacyPolicyStartUse => 'By using, you agree to this policy.';

  @override
  String get confirm => 'Confirm';

  @override
  String get pleaseConfirmAgreementAndPrivacyPolicy =>
      'Please confirm that you have agreed to the terms of service and privacy policy';

  @override
  String get validation_ageNotConfirmed =>
      'You need to confirm that you are at least 18 years old and agree to our privacy policy';

  @override
  String get validation_acceptedAgeOf18 =>
      'I confirm I am at least 18 years old and agree to the terms of service';

  @override
  String get validation_acceptedAgeOf18_prefix =>
      'I confirm I am at least 18 years old and agree to the ';

  @override
  String get validation_accepted_checkbox => 'By checking, you agree to';

  @override
  String get validation_acceptedAgeOf18_link => 'terms of service';

  @override
  String get privacyPolicyTitle => 'Privacy Policy';

  @override
  String get chart_period_1min => '1m';

  @override
  String get chart_period_15min => '15m';

  @override
  String get chart_period_30min => '30m';

  @override
  String get chart_period_1hour => '1h';

  @override
  String get chart_period_4hour => '4h';

  @override
  String get chart_period_1day => '1D';

  @override
  String get chart_period_5min => '5m';

  @override
  String get noAnalysis => 'No analysis';

  @override
  String get allNetwork => 'All';

  @override
  String receiveAddressExplain1(Object symbol) {
    return 'This is a $symbol network universal address';
  }

  @override
  String receiveAddressExplain2(Object symbol) {
    return 'Only $symbol network assets can be received';
  }

  @override
  String get userAgreement => 'User Agreement';

  @override
  String get and => 'and';

  @override
  String get startUsing => 'Start Using';

  @override
  String get loading => 'Loading...';

  @override
  String get trackSuccess => 'Successfully';

  @override
  String get bonus => 'Bonus';

  @override
  String get inviteDesc =>
      'Invite friends. Profit with AI.\nScore a referral bonus.';

  @override
  String get myInviteCode => 'My invite code';

  @override
  String get inviteLink => 'Invite link';

  @override
  String get inviteBonus => 'Invite bonus';

  @override
  String get bind => 'Use';

  @override
  String get friendInviteCode => ' your friend\'s invite code';

  @override
  String getGoldBonus(Object amount) {
    return ' and get $amount \$GOLD!';
  }

  @override
  String get myBonus => 'You\'ve earned';

  @override
  String get unclaimedGold => 'Unclaimed GOLD';

  @override
  String get unclaimedFunds => 'Unclaimed Funds';

  @override
  String get claim => 'Claim';

  @override
  String get invitee => 'Invitee';

  @override
  String get inviteeTrade => 'Invitee Trading Volume';

  @override
  String get bonusDetails => 'Bonus Details';

  @override
  String get claimFunds => 'Claim Funds';

  @override
  String get claimFundsDesc =>
      'One invite, rewards across all chains.\nWhen your friends trade on any chain, you earn bonuses.';

  @override
  String get bindReferrerInviteCode => 'Add your inviter’s code';

  @override
  String get earn => 'Earn';

  @override
  String get reward => 'Reward';

  @override
  String get inputInviteCode => 'Enter your invite code.';

  @override
  String get goldDesc =>
      '\$GOLD is an early-user benefit and proof for future AIGun token claims.';

  @override
  String get inviteCodeInputError =>
      'Invalid invite code. Please check and try again.';

  @override
  String minimumClaim(Object amount, Object token) {
    return 'Minimum $amount $token to claim';
  }

  @override
  String get aboutGold => 'About GOLD';

  @override
  String get getGoldWay => 'You can earn GOLD in three ways:';

  @override
  String get getGoldWay1 =>
      '1. Earn GOLD through trading — get 1 GOLD for every \$100 traded.';

  @override
  String get getGoldWay2 =>
      '2. Invite friends to use AIGun — when they claim their GOLD, you’ll earn GOLD too.';

  @override
  String get getGoldWay3 =>
      '3. Earn GOLD through mining — coming soon in the app.';

  @override
  String get know => 'Got it';

  @override
  String get sendCodeSuccess => 'Send code successfully';

  @override
  String get emailFormatError => 'Email format error, send code failed';

  @override
  String get sendCodeFail => 'Send code failed';

  @override
  String get sendCodeMany => 'Send code too frequently';

  @override
  String get unknownErrorSendCode => 'Unknown error, send code failed';

  @override
  String get resendCodeSuccess => 'Resend code successfully, please check';

  @override
  String get createThanksMessageFail =>
      'Create thanks message failed, jump after 2 seconds';

  @override
  String get userNotExistToJump => 'User not exist, jump after 2 seconds';

  @override
  String get inviteCodeInvalidToJump =>
      'Invite code invalid, jump after 2 seconds';

  @override
  String get unknownErrorToJump =>
      'Create thanks message failed, jump after 2 seconds';

  @override
  String get inviteSuccess =>
      'Awesome! The invite code is valid. You\'ve received a power bonus and activated Level 2 rewards! Pick a message to thank your inviter.';

  @override
  String get inviteSuccessDesc => 'You say to the inviter:';

  @override
  String get inviteSuccessMessage1 =>
      'Thanks for getting me into DogeX, my dude! Wishing you all the best.';

  @override
  String get inviteSuccessMessage2 =>
      'Appreciate the golden ticket, pal. I owe you one big time for this.';

  @override
  String get inviteSuccessMessage3 =>
      'This invite took me from zero to hero in a flash! Thanks a ton, bro!';

  @override
  String get inviteSuccessMessage4 =>
      'Your invite is like hitting the jackpot on steroids! My future\'s so bright, I gotta wear shades!';

  @override
  String get inviteSuccessMessage5 =>
      'The moment I got your invite, felt like I won the lottery! You call the shots from now on, boss!';

  @override
  String get inviteSuccessMessage6 =>
      'Is this invite a cheat code for getting rich? You\'re my life guru now, pinned to the top of my contacts!';

  @override
  String get inviteSuccessMessage7 =>
      'OMG, fam, who feels me?! My bro got me in, and I\'m about to make it rain! Absolute win!';

  @override
  String get inviteSuccessMessage8 =>
      'This invite is legendary! You\'re a modern-day MVP in my book. I\'ve got your back, always.';

  @override
  String get inviteSuccessMessage9 =>
      'So patrons are real! This invite sent me straight to the moon! I\'m your number one fan now!';

  @override
  String get inviteSuccessMessage10 =>
      'Who knew one invite could turn me from a broke gamer to a VIP pass holder! Eternally grateful, my friend!';

  @override
  String get notSupportInputReceiveTokenAmount =>
      'Not support input receive token amount';

  @override
  String get networkIsNotConnected =>
      'Your network seems to have some issues, please connect to the network and try again';

  @override
  String get servicesAreNotHealthy =>
      'Our services seem to have some issues, please try again later';

  @override
  String get tradeParamsInvalid => 'Trade params invalid';

  @override
  String get pleaseEnterCorrectEmail =>
      'Please enter the correct email address';

  @override
  String bonusDetailsItem1(Object doller, Object name) {
    return '$name made a trade, and I earned \$$doller.';
  }

  @override
  String bonusDetailsItem2(Object gold, Object name) {
    return '$name claimed GOLD, and I earned $gold GOLD.';
  }

  @override
  String bonusDetailsItem3(Object gold) {
    return 'I made a trade and earned $gold GOLD.';
  }

  @override
  String bonusDetailsItem4(Object doller, Object name) {
    return '$name subscribed to VIP, and I earned \$$doller.';
  }

  @override
  String bonusDetailsItem5(Object gold, Object name) {
    return 'I invited $name to join AIGun and earned $gold GOLD.';
  }

  @override
  String get claimSuccess => 'Claim Successful';

  @override
  String get bindSuccess => 'Bind Successful';

  @override
  String get claimWaiting => 'Withdrawing...\nPlease wait.';

  @override
  String get noReceivedFromServer =>
      'No data has been received from the service.';

  @override
  String get retry => 'Retry';

  @override
  String get noIntelData => 'No Intelligence Data';

  @override
  String get refresh => 'Refresh';

  @override
  String get sourceLink => 'Source Link';

  @override
  String get recommend => 'Recommend';

  @override
  String get chainSingle => 'On Chain Signal';

  @override
  String get noTokens => 'No tokens yet, please get tokens first';

  @override
  String get errorUnknownError => 'Unknown error';

  @override
  String get errorParamInvalid => 'Invalid parameter';

  @override
  String get errorParamMissing => 'Missing parameter';

  @override
  String get errorAuthFailed => 'Authentication failed';

  @override
  String get errorDataNotFound => 'Data not found';

  @override
  String get errorDataExist => 'Data already exists';

  @override
  String get errorDataParseFail => 'Data parsing failed';

  @override
  String get errorExternalFail => 'External service failed';

  @override
  String get errorDatabaseFail => 'Database error';

  @override
  String get errorTxInsufficient => 'Insufficient balance';

  @override
  String get errorTxTransferFail => 'Transfer failed';

  @override
  String get errorTxSwapFail => 'Swap failed';

  @override
  String get errorTxBroadcastFail => 'Broadcast failed';

  @override
  String get errorChainNotSupport => 'Chain not supported';

  @override
  String get errorAggCallFailed => 'Aggregator failed';

  @override
  String get errorChainCallFailed => 'Chain call failed';

  @override
  String get errorTkGenP256Fail => 'P256 generation failed';

  @override
  String get errorTkEncryptFail => 'P256 encryption failed';

  @override
  String get errorTkClientFail => 'Client acquisition failed';

  @override
  String get errorTkCreateOrgFail => 'Organization creation failed';

  @override
  String get errorTkGetDataFail => 'Data query failed';

  @override
  String get errorTkDbFail => 'Database error';

  @override
  String get errorTkSignFail => 'Signature failed';

  @override
  String get errorTkCreateAccFail => 'Address creation failed';

  @override
  String get errorTkDeleteOrgFail => 'Organization deletion failed';

  @override
  String get errorTransactionSimulationFailed =>
      'Transaction simulation failed';

  @override
  String get feeNotEnough => 'Fee not enough';

  @override
  String get checking => 'Checking...';
}
