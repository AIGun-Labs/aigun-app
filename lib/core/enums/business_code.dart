library;

enum BusinessCode {
  ok(0, 'OK'),
  error(200000, ''),
  authFail(200001, ''),
  pydanticVerifyFail(200002, 'Pydantic '),
  loginFail(200007, ''),
  requiredParamMissing(200008, ''),
  requestParamVerifyFailed(200009, ''),
  dbError(200010, ''),
  tooManyRequests(200011, ''),
  lengthInvalid(20012, ''),
  emailSendFail(200101, ''),
  emailVerifyCodeExpired(200102, ''),
  emailVerifyCodeError(200103, ''),
  emailVerifyCodeSendFail(200104, ''),
  emailVerifyCodeCheckFail(200105, ''),
  emailVerifyCodeCheckSuccess(200106, ''),
  emailVerifyCodeCheckRepeat(200107, ''),
  emailVerifyCodeCheckTooMany(200108, ''),
  emailVerifyCodeCheckTooFast(200109, ''),
  invalidEmail(200110, ''),
  nicknameInvalid(200114, ''),
  refreshTokenInvalid(200115, ' token'),
  createWalletFail(200116, ''),
  walletUserExists(200117, ''),
  walletPinInvalid(200118, ''),
  trxConfigParamError(200119, ''),
  walletUserNotExists(200120, ''),
  userNotExist(200200, ''),
  userExist(200201, ''),
  userCreateFail(200202, ''),
  userUpdateFail(200203, ''),
  inviteUserFail(200204, ''),
  inviteVoid(200205, ''),
  userAlreadyActive(200206, ''),
  userCannotBindSelf(200207, ''),
  invalidUserMessage(200208, ''),
  invalidParameter(200209, ''),
  deviceNotExist(200210, ''),
  deviceBindFail(200211, ''),
  emailHasBindOtherAccount(200212, ' tid '),
  telegramAccountHasBoundEmail(200213, ''),
  invalidInitData(200214, ''),
  invalidRegisterMethods(200215, ''),
  newAndOldIdVerifyFail(200216, ' id '),
  tokenHasCollected(200300, ''),
  tokenCollectLimit(200301, ''),
  alreadyFollowed(200400, ''),
  aiAgentNotFound(200401, 'AI Agent '),
  notFollowed(200402, ''),
  subsetNotFound(200403, 'Subset '),
  invalidSubsetType(200404, 'Subset ');

  final int code;
  final String defaultMessage;
  const BusinessCode(this.code, this.defaultMessage);

  static BusinessCode? fromCode(int code) {
    for (final e in BusinessCode.values) {
      if (e.code == code) return e;
    }
    return null;
  }
}
