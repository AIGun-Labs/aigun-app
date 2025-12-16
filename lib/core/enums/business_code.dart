/// 业务相关错误
library;

enum BusinessCode {
  ok(0, 'OK'),
  error(200000, '未知错误'),
  authFail(200001, '身份验证失败'),
  pydanticVerifyFail(200002, 'Pydantic 校验失败'),
  loginFail(200007, '登录账号密码错误'),
  requiredParamMissing(200008, '缺少必需的参数'),
  requestParamVerifyFailed(200009, '请求参数校验失败'),
  dbError(200010, '数据库操作失败'),
  tooManyRequests(200011, '触发限流'),
  lengthInvalid(20012, '无效的字段长度'),

  // 邮箱 & 验证码
  emailSendFail(200101, '邮件发送失败'),
  emailVerifyCodeExpired(200102, '验证码过期'),
  emailVerifyCodeError(200103, '验证码错误'),
  emailVerifyCodeSendFail(200104, '验证码发送失败'),
  emailVerifyCodeCheckFail(200105, '验证码校验失败'),
  emailVerifyCodeCheckSuccess(200106, '验证码校验成功'),
  emailVerifyCodeCheckRepeat(200107, '验证码校验重复'),
  emailVerifyCodeCheckTooMany(200108, '验证码校验次数过多'),
  emailVerifyCodeCheckTooFast(200109, '验证码校验过于频繁'),
  invalidEmail(200110, '无效的邮箱'),
  nicknameInvalid(200114, '昵称长度不合法'),
  refreshTokenInvalid(200115, '无效的刷新 token'),

  // 钱包
  createWalletFail(200116, '创建钱包用户失败'),
  walletUserExists(200117, '钱包用户已存在'),
  walletPinInvalid(200118, '无效的钱包密码'),
  trxConfigParamError(200119, '交易配置参数错误'),
  walletUserNotExists(200120, '钱包用户不存在'),

  // 用户
  userNotExist(200200, '用户不存在'),
  userExist(200201, '用户已存在'),
  userCreateFail(200202, '用户创建失败'),
  userUpdateFail(200203, '用户更新失败'),
  inviteUserFail(200204, '添加邀请人失败'),
  inviteVoid(200205, '邀请人不存在'),
  userAlreadyActive(200206, '用户已激活'),
  userCannotBindSelf(200207, '用户不能绑定自己'),
  invalidUserMessage(200208, '无效的消息'),
  invalidParameter(200209, '无效的参数'),
  deviceNotExist(200210, '设备不存在'),
  deviceBindFail(200211, '设备绑定失败'),
  emailHasBindOtherAccount(200212, '邮箱已绑定其他 tid 账号'),
  telegramAccountHasBoundEmail(200213, '电报账号已绑定其他邮箱'),
  invalidInitData(200214, '非法的初始数据'),
  invalidRegisterMethods(200215, '非法的注册方式'),
  newAndOldIdVerifyFail(200216, '新旧账户 id 不存在或不相等'),

  // 趋势
  tokenHasCollected(200300, '收藏代币已存在'),
  tokenCollectLimit(200301, '超过收藏代币上限'),

  // AI Agent 关注
  alreadyFollowed(200400, '已关注'),
  aiAgentNotFound(200401, 'AI Agent 不存在'),
  notFollowed(200402, '未关注'),
  subsetNotFound(200403, 'Subset 不存在'),
  invalidSubsetType(200404, 'Subset 类型非法');

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
