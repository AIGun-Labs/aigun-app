// 错误大类（与后端的第二段 01/02/03... 对齐）
enum ErrKind {
  unknown(0),
  param(1),
  auth(2),
  data(3),
  logic(4),
  external(5);

  final int id;
  const ErrKind(this.id);
}

// 具体业务错误（与后端六位码对齐：SS KK II => service*10000 + kind*100 + idx）
enum AppErrorCode {
  unknownError(0, ErrKind.unknown, 1, '未知错误'), // 990001
  // —— 通用(99)
  paramInvalid(99, ErrKind.param, 1, '参数无效'), // 990101
  paramMissing(99, ErrKind.param, 2, '参数缺失'), // 990102
  authFailed(99, ErrKind.auth, 1, '认证失败'), // 990201
  dataNotFound(99, ErrKind.data, 1, '数据未找到'), // 990301
  dataExist(99, ErrKind.data, 2, '数据已存在'), // 990302
  dataParseFail(99, ErrKind.logic, 2, '数据解析失败'), // 990402
  externalFail(99, ErrKind.external, 1, '外部服务失败'), // 990501
  databaseFail(99, ErrKind.external, 2, '数据库失败'), // 990502

  // —— Tx(22)
  txInsufficient(22, ErrKind.data, 1, '余额不足'), // 220301
  txTransferFail(22, ErrKind.logic, 1, '转账执行失败'), // 220401
  txSwapFail(22, ErrKind.logic, 2, 'Swap 执行失败'), // 220402
  txBroadcastFail(22, ErrKind.external, 1, '广播失败'), // 220501

  // —— Chain(23)
  chainNotSupport(23, ErrKind.param, 1, '链不支持'), // 230101
  aggCallFailed(23, ErrKind.external, 1, '聚合器失败'), // 230501
  chainCallFailed(23, ErrKind.external, 2, '链调用失败'), // 230502

  // —— Turnkey(24)
  tkGenP256Fail(24, ErrKind.logic, 1, '生成 P256 失败'), // 240401
  tkEncryptFail(24, ErrKind.logic, 2, '加密 P256 失败'), // 240402
  tkClientFail(24, ErrKind.logic, 3, '获取客户端失败'), // 240403
  tkCreateOrgFail(24, ErrKind.external, 1, '创建子组织失败'), // 240501
  tkGetDataFail(24, ErrKind.external, 2, '数据查询失败'), // 240502
  tkDbFail(24, ErrKind.external, 3, '数据库失败'), // 240503
  tkSignFail(24, ErrKind.external, 4, '签名失败'), // 240504
  tkCreateAccFail(24, ErrKind.external, 5, '创建地址失败'), // 240505
  tkDeleteOrgFail(24, ErrKind.external, 6, '删除子组织失败'); // 240506

  final int service;
  final ErrKind kind;
  final int idx;
  final String defaultMessage;
  const AppErrorCode(this.service, this.kind, this.idx, this.defaultMessage);

  int get code => service * 10000 + kind.id * 100 + idx;

  static AppErrorCode? fromCode(int code) {
    for (final e in AppErrorCode.values) {
      if (e.code == code) return e;
    }
    return null;
  }
}
