part of 'index.dart';

enum BusinessStatusCode {
  ok(0),
  error(200000),
  authFail(200001),
  pydanticVerifyFail(200002),
  loginFail(200007),
  requiredParamMissing(200008),
  requestParamVerifyFailed(200009),
  dbError(200010),
  tooManyRequests(200011),

  userNotExist(200200),
  userExist(200201),
  userCreateFail(200202),
  userUpdateFail(200203),
  inviteUserFail(200204),
  inviteVoid(200205),
  userAlreadyActive(200206),
  userCannotBindSelf(200207),
  invalidUserMessage(200208),
  invalidParameter(200209),
  deviceNotExist(200210),
  deviceBandFail(200211),
  emailHasBindOtherAccount(200212),
  telegramAccountHasBoundEmail(200213),
  invalidInitData(200214),
  invalidRegisterMethods(200215),
  newAndOldIdVerifyFail(200216),

  emailSendFail(200101),
  emailVerifyCodeExpired(200102),
  emailVerifyCodeError(200103),
  emailVerifyCodeSendFail(200104),
  emailVerifyCodeCheckFail(200105),
  emailVerifyCodeCheckSuccess(200106),
  emailVerifyCodeCheckRepeat(200107),
  emailVerifyCodeCheckTooMany(200108),
  emailVerifyCodeCheckTooFast(200109),
  invalidEmail(200110),
  nicknameInvalid(200114),
  refreshTokenInvalid(200115);

  const BusinessStatusCode(this.code);
  final int code;

  static BusinessStatusCode? fromCode(int code) {
    for (final status in BusinessStatusCode.values) {
      if (status.code == code) {
        return status;
      }
    }
    return null;
  }

  bool get isSuccess => this == BusinessStatusCode.ok;

  bool get isError => this != BusinessStatusCode.ok;

  String get description {
    switch (this) {
      case BusinessStatusCode.ok:
        return '';
      case BusinessStatusCode.error:
        return '';
      case BusinessStatusCode.authFail:
        return '';
      case BusinessStatusCode.pydanticVerifyFail:
        return 'Pydantic';
      case BusinessStatusCode.loginFail:
        return '';
      case BusinessStatusCode.requiredParamMissing:
        return '，';
      case BusinessStatusCode.requestParamVerifyFailed:
        return '';
      case BusinessStatusCode.dbError:
        return '';
      case BusinessStatusCode.tooManyRequests:
        return '';
      case BusinessStatusCode.userNotExist:
        return '';
      case BusinessStatusCode.userExist:
        return '';
      case BusinessStatusCode.userCreateFail:
        return '';
      case BusinessStatusCode.userUpdateFail:
        return '';
      case BusinessStatusCode.inviteUserFail:
        return '';
      case BusinessStatusCode.inviteVoid:
        return '';
      case BusinessStatusCode.userAlreadyActive:
        return '';
      case BusinessStatusCode.userCannotBindSelf:
        return '';
      case BusinessStatusCode.invalidUserMessage:
        return '';
      case BusinessStatusCode.invalidParameter:
        return '';
      case BusinessStatusCode.deviceNotExist:
        return '';
      case BusinessStatusCode.deviceBandFail:
        return '';
      case BusinessStatusCode.emailHasBindOtherAccount:
        return 'tid';
      case BusinessStatusCode.telegramAccountHasBoundEmail:
        return '';
      case BusinessStatusCode.invalidInitData:
        return '';
      case BusinessStatusCode.invalidRegisterMethods:
        return '（tid）';
      case BusinessStatusCode.newAndOldIdVerifyFail:
        return 'id';
      case BusinessStatusCode.emailSendFail:
        return '';
      case BusinessStatusCode.emailVerifyCodeExpired:
        return '';
      case BusinessStatusCode.emailVerifyCodeError:
        return '';
      case BusinessStatusCode.emailVerifyCodeSendFail:
        return '';
      case BusinessStatusCode.emailVerifyCodeCheckFail:
        return '';
      case BusinessStatusCode.emailVerifyCodeCheckSuccess:
        return '';
      case BusinessStatusCode.emailVerifyCodeCheckRepeat:
        return '';
      case BusinessStatusCode.emailVerifyCodeCheckTooMany:
        return '';
      case BusinessStatusCode.emailVerifyCodeCheckTooFast:
        return '';
      case BusinessStatusCode.invalidEmail:
        return '';
      case BusinessStatusCode.nicknameInvalid:
        return '';
      case BusinessStatusCode.refreshTokenInvalid:
        return '';
    }
  }
}
