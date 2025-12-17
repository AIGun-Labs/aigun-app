import 'package:flutter/material.dart';

import '../core/enums/app_error.dart';
import '../infrastructure/network/error/app_exception.dart';
import '../l10n/l10n.dart';
import 'logger.dart';

/// 错误处理工具类
class ErrorHandlerUtils {
  static String getErrorMessageFromException(
    Object error,
    BuildContext context,
  ) {
    // 检查是否为 DioException
    if (error is BusinessException) {
      final businessException = error;
      final code = businessException.code;

      // 根据 code 映射到 AppErrorCode
      final appErrorCode = AppErrorCode.fromCode(code!);
      Logger.error('appErrorCode: $appErrorCode');

      if (appErrorCode != null) {
        // 使用 AppErrorCode 的枚举名称构造国际化 key (小驼峰格式)
        final errorKey =
            'error${appErrorCode.name[0].toUpperCase()}${appErrorCode.name.substring(1)}';

        // 通过反射或 switch 获取对应的国际化文本
        final errorMessage = _getLocalizedErrorMessage(errorKey, context);

        return errorMessage;
      }

      // 如果找不到映射，返回后端的 msg
      if (businessException.message.isNotEmpty) {
        return businessException.message;
      }
    }

    // 默认错误消息
    return S.of(context).unknownError;
  }

  static String getErrorMessageFromCode(dynamic code, BuildContext context) {
    final appErrorCode = AppErrorCode.fromCode(code);
    if (appErrorCode == null) {
      return S.of(context).tradeFailedAgain;
    }
    // 使用 AppErrorCode 的枚举名称构造国际化 key (小驼峰格式)
    final errorKey =
        'error${appErrorCode.name[0].toUpperCase()}${appErrorCode.name.substring(1)}';

    // 通过反射或 switch 获取对应的国际化文本
    final errorMessage = _getLocalizedErrorMessage(errorKey, context);

    return errorMessage;
  }

  static String _getLocalizedErrorMessage(
    String? errorKey,
    BuildContext context,
  ) {
    final s = S.of(context);

    // 使用 switch 根据 errorKey 返回对应的国际化文本
    switch (errorKey) {
      case 'errorUnknownError':
        return s.errorUnknownError;
      case 'errorParamInvalid':
        return s.errorParamInvalid;
      case 'errorParamMissing':
        return s.errorParamMissing;
      case 'errorAuthFailed':
        return s.errorAuthFailed;
      case 'errorDataNotFound':
        return s.errorDataNotFound;
      case 'errorDataExist':
        return s.errorDataExist;
      case 'errorDataParseFail':
        return s.errorDataParseFail;
      case 'errorExternalFail':
        return s.errorExternalFail;
      case 'errorDatabaseFail':
        return s.errorDatabaseFail;
      case 'errorTxInsufficient':
        return s.errorTxInsufficient;
      case 'errorTxTransferFail':
        return s.errorTxTransferFail;
      case 'errorTxSwapFail':
        return s.errorTxSwapFail;
      case 'errorTxBroadcastFail':
        return s.errorTxBroadcastFail;
      case 'errorChainNotSupport':
        return s.errorChainNotSupport;
      case 'errorAggCallFailed':
        return s.errorAggCallFailed;
      case 'errorChainCallFailed':
        return s.errorChainCallFailed;
      case 'errorTkGenP256Fail':
        return s.errorTkGenP256Fail;
      case 'errorTkEncryptFail':
        return s.errorTkEncryptFail;
      case 'errorTkClientFail':
        return s.errorTkClientFail;
      case 'errorTkCreateOrgFail':
        return s.errorTkCreateOrgFail;
      case 'errorTkGetDataFail':
        return s.errorTkGetDataFail;
      case 'errorTkDbFail':
        return s.errorTkDbFail;
      case 'errorTkSignFail':
        return s.errorTkSignFail;
      case 'errorTkCreateAccFail':
        return s.errorTkCreateAccFail;
      case 'errorTkDeleteOrgFail':
        return s.errorTkDeleteOrgFail;
      case 'errorTransactionSimulationFailed':
        return s.errorTransactionSimulationFailed;
      default:
        return s.tradeFailedAgain;
    }
  }
}
