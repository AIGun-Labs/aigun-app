import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../enums/business_code.dart';

class BusinessCodeHandler {
  static String getErrorMessageFromBusinessCode(
    BuildContext context,
    int code,
  ) {
    final businessCode = BusinessCode.fromCode(code);
    if (businessCode == null) {
      return S.of(context).unknownError;
    }

    final s = S.of(context);

    return switch (businessCode) {
      // 通用
      BusinessCode.ok => s.bizOk,
      BusinessCode.error => s.bizError,
      BusinessCode.authFail => s.bizAuthFail,
      BusinessCode.pydanticVerifyFail => s.bizPydanticVerifyFail,
      BusinessCode.loginFail => s.bizLoginFail,
      BusinessCode.requiredParamMissing => s.bizRequiredParamMissing,
      BusinessCode.requestParamVerifyFailed => s.bizRequestParamVerifyFailed,
      BusinessCode.dbError => s.bizDbError,
      BusinessCode.tooManyRequests => s.bizTooManyRequests,
      BusinessCode.lengthInvalid => s.bizLengthInvalid,

      // 邮箱 & 验证码
      BusinessCode.emailSendFail => s.bizEmailSendFail,
      BusinessCode.emailVerifyCodeExpired => s.bizEmailVerifyCodeExpired,
      BusinessCode.emailVerifyCodeError => s.bizEmailVerifyCodeError,
      BusinessCode.emailVerifyCodeSendFail => s.bizEmailVerifyCodeSendFail,
      BusinessCode.emailVerifyCodeCheckFail => s.bizEmailVerifyCodeCheckFail,
      BusinessCode.emailVerifyCodeCheckSuccess =>
        s.bizEmailVerifyCodeCheckSuccess,
      BusinessCode.emailVerifyCodeCheckRepeat =>
        s.bizEmailVerifyCodeCheckRepeat,
      BusinessCode.emailVerifyCodeCheckTooMany =>
        s.bizEmailVerifyCodeCheckTooMany,
      BusinessCode.emailVerifyCodeCheckTooFast =>
        s.bizEmailVerifyCodeCheckTooFast,
      BusinessCode.invalidEmail => s.bizInvalidEmail,
      BusinessCode.nicknameInvalid => s.bizNicknameInvalid,
      BusinessCode.refreshTokenInvalid => s.bizRefreshTokenInvalid,

      // 钱包
      BusinessCode.createWalletFail => s.bizCreateWalletFail,
      BusinessCode.walletUserExists => s.bizWalletUserExists,
      BusinessCode.walletPinInvalid => s.bizWalletPinInvalid,
      BusinessCode.trxConfigParamError => s.bizTrxConfigParamError,
      BusinessCode.walletUserNotExists => s.bizWalletUserNotExists,

      // 用户
      BusinessCode.userNotExist => s.bizUserNotExist,
      BusinessCode.userExist => s.bizUserExist,
      BusinessCode.userCreateFail => s.bizUserCreateFail,
      BusinessCode.userUpdateFail => s.bizUserUpdateFail,
      BusinessCode.inviteUserFail => s.bizInviteUserFail,
      BusinessCode.inviteVoid => s.bizInviteVoid,
      BusinessCode.userAlreadyActive => s.bizUserAlreadyActive,
      BusinessCode.userCannotBindSelf => s.bizUserCannotBindSelf,
      BusinessCode.invalidUserMessage => s.bizInvalidUserMessage,
      BusinessCode.invalidParameter => s.bizInvalidParameter,
      BusinessCode.deviceNotExist => s.bizDeviceNotExist,
      BusinessCode.deviceBindFail => s.bizDeviceBindFail,
      BusinessCode.emailHasBindOtherAccount => s.bizEmailHasBindOtherAccount,
      BusinessCode.telegramAccountHasBoundEmail =>
        s.bizTelegramAccountHasBoundEmail,
      BusinessCode.invalidInitData => s.bizInvalidInitData,
      BusinessCode.invalidRegisterMethods => s.bizInvalidRegisterMethods,
      BusinessCode.newAndOldIdVerifyFail => s.bizNewAndOldIdVerifyFail,

      // 趋势
      BusinessCode.tokenHasCollected => s.bizTokenHasCollected,
      BusinessCode.tokenCollectLimit => s.bizTokenCollectLimit,

      // AI Agent 关注
      BusinessCode.alreadyFollowed => s.bizAlreadyFollowed,
      BusinessCode.aiAgentNotFound => s.bizAiAgentNotFound,
      BusinessCode.notFollowed => s.bizNotFollowed,
      BusinessCode.subsetNotFound => s.bizSubsetNotFound,
      BusinessCode.invalidSubsetType => s.bizInvalidSubsetType,

      // 未匹配到的情况下，兜底返回后端默认文案
      _ => businessCode.defaultMessage,
    };
  }
}
