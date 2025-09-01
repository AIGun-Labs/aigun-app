part of 'index.dart';

enum BusinessStatusCode {
  // 基础状态码
  ok(0),
  error(200000),
  authFail(200001), // 身份验证失败
  pydanticVerifyFail(200002), // Pydantic校验失败
  loginFail(200007), // 登录账号密码错误
  requiredParamMissing(200008), // 请求失败，缺少必需的参数
  requestParamVerifyFailed(200009), // 请求参数校验失败
  dbError(200010), // 数据库操作失败
  tooManyRequests(200011), // 触发限流

  // 用户模块
  userNotExist(200200), // 用户不存在
  userExist(200201), // 用户已存在
  userCreateFail(200202), // 用户创建失败
  userUpdateFail(200203), // 用户更新失败
  inviteUserFail(200204), // 添加邀请人失败
  inviteVoid(200205), // 邀请人不存在
  userAlreadyActive(200206), // 用户已激活
  userCannotBindSelf(200207), // 用户不能绑定自己
  invalidUserMessage(200208), // 无效的消息
  invalidParameter(200209), // 无效的参数
  deviceNotExist(200210), // 设备不存在
  deviceBandFail(200211), // 设备绑定失败
  emailHasBindOtherAccount(200212), // 邮箱账号已绑定其他tid账号
  telegramAccountHasBoundEmail(200213), // 电报账号已绑定其他邮箱
  invalidInitData(200214), // 非法的初始数据
  invalidRegisterMethods(200215), // 非法的注册方法（只能通过邮箱或tid注册）
  newAndOldIdVerifyFail(200216), // 新旧账户id不存在或不相等

  // 邮件验证模块
  emailSendFail(200101), // 邮件发送失败
  emailVerifyCodeExpired(200102), // 验证码过期
  emailVerifyCodeError(200103), // 验证码错误
  emailVerifyCodeSendFail(200104), // 验证码发送失败
  emailVerifyCodeCheckFail(200105), // 验证码校验失败
  emailVerifyCodeCheckSuccess(200106), // 验证码校验成功
  emailVerifyCodeCheckRepeat(200107), // 验证码校验重复
  emailVerifyCodeCheckTooMany(200108), // 验证码校验次数过多
  emailVerifyCodeCheckTooFast(200109), // 验证码校验过于频繁
  invalidEmail(200110), // 无效的邮箱
  nicknameInvalid(200114), // 用户名称长度不合法
  refreshTokenInvalid(200115), // 刷新令牌无效
  ;

  const BusinessStatusCode(this.code);
  final int code;

  /// 根据状态码获取枚举值
  static BusinessStatusCode? fromCode(int code) {
    for (final status in BusinessStatusCode.values) {
      if (status.code == code) {
        return status;
      }
    }
    return null;
  }

  /// 检查是否为成功状态
  bool get isSuccess => this == BusinessStatusCode.ok;

  /// 检查是否为错误状态
  bool get isError => this != BusinessStatusCode.ok;

  /// 获取状态码描述
  String get description {
    switch (this) {
      case BusinessStatusCode.ok:
        return '成功';
      case BusinessStatusCode.error:
        return '错误';
      case BusinessStatusCode.authFail:
        return '身份验证失败';
      case BusinessStatusCode.pydanticVerifyFail:
        return 'Pydantic校验失败';
      case BusinessStatusCode.loginFail:
        return '登录账号密码错误';
      case BusinessStatusCode.requiredParamMissing:
        return '请求失败，缺少必需的参数';
      case BusinessStatusCode.requestParamVerifyFailed:
        return '请求参数校验失败';
      case BusinessStatusCode.dbError:
        return '数据库操作失败';
      case BusinessStatusCode.tooManyRequests:
        return '触发限流';
      case BusinessStatusCode.userNotExist:
        return '用户不存在';
      case BusinessStatusCode.userExist:
        return '用户已存在';
      case BusinessStatusCode.userCreateFail:
        return '用户创建失败';
      case BusinessStatusCode.userUpdateFail:
        return '用户更新失败';
      case BusinessStatusCode.inviteUserFail:
        return '添加邀请人失败';
      case BusinessStatusCode.inviteVoid:
        return '邀请人不存在';
      case BusinessStatusCode.userAlreadyActive:
        return '用户已激活';
      case BusinessStatusCode.userCannotBindSelf:
        return '用户不能绑定自己';
      case BusinessStatusCode.invalidUserMessage:
        return '无效的消息';
      case BusinessStatusCode.invalidParameter:
        return '无效的参数';
      case BusinessStatusCode.deviceNotExist:
        return '设备不存在';
      case BusinessStatusCode.deviceBandFail:
        return '设备绑定失败';
      case BusinessStatusCode.emailHasBindOtherAccount:
        return '邮箱账号已绑定其他tid账号';
      case BusinessStatusCode.telegramAccountHasBoundEmail:
        return '电报账号已绑定其他邮箱';
      case BusinessStatusCode.invalidInitData:
        return '非法的初始数据';
      case BusinessStatusCode.invalidRegisterMethods:
        return '非法的注册方法（只能通过邮箱或tid注册）';
      case BusinessStatusCode.newAndOldIdVerifyFail:
        return '新旧账户id不存在或不相等';
      case BusinessStatusCode.emailSendFail:
        return '邮件发送失败';
      case BusinessStatusCode.emailVerifyCodeExpired:
        return '验证码过期';
      case BusinessStatusCode.emailVerifyCodeError:
        return '验证码错误';
      case BusinessStatusCode.emailVerifyCodeSendFail:
        return '验证码发送失败';
      case BusinessStatusCode.emailVerifyCodeCheckFail:
        return '验证码校验失败';
      case BusinessStatusCode.emailVerifyCodeCheckSuccess:
        return '验证码校验成功';
      case BusinessStatusCode.emailVerifyCodeCheckRepeat:
        return '验证码校验重复';
      case BusinessStatusCode.emailVerifyCodeCheckTooMany:
        return '验证码校验次数过多';
      case BusinessStatusCode.emailVerifyCodeCheckTooFast:
        return '验证码校验过于频繁';
      case BusinessStatusCode.invalidEmail:
        return '无效的邮箱';
      case BusinessStatusCode.nicknameInvalid:
        return '用户名称长度不合法';
      case BusinessStatusCode.refreshTokenInvalid:
        return '刷新令牌无效';
    }
  }
}
