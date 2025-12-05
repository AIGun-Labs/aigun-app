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

enum AppErrorCode {
  unknownError(0, ErrKind.unknown, 1, ''), // 990001

  paramInvalid(99, ErrKind.param, 1, ''), // 990101
  paramMissing(99, ErrKind.param, 2, ''), // 990102
  authFailed(99, ErrKind.auth, 1, ''), // 990201
  dataNotFound(99, ErrKind.data, 1, ''), // 990301
  dataExist(99, ErrKind.data, 2, ''), // 990302
  dataParseFail(99, ErrKind.logic, 2, ''), // 990402
  externalFail(99, ErrKind.external, 1, ''), // 990501
  databaseFail(99, ErrKind.external, 2, ''), // 990502

  // —— Tx(22)
  txInsufficient(22, ErrKind.data, 1, ''), // 220301
  txTransferFail(22, ErrKind.logic, 1, ''), // 220401
  txSwapFail(22, ErrKind.logic, 2, 'Swap '), // 220402
  txBroadcastFail(22, ErrKind.external, 1, ''), // 220501
  transactionSimulationFailed(22, ErrKind.external, 2, ''), // 220502

  // —— Chain(23)
  chainNotSupport(23, ErrKind.param, 1, ''), // 230101
  aggCallFailed(23, ErrKind.external, 1, ''), // 230501
  chainCallFailed(23, ErrKind.external, 2, ''), // 230502

  // —— Turnkey(24)
  tkGenP256Fail(24, ErrKind.logic, 1, ' P256 '), // 240401
  tkEncryptFail(24, ErrKind.logic, 2, ' P256 '), // 240402
  tkClientFail(24, ErrKind.logic, 3, ''), // 240403
  tkCreateOrgFail(24, ErrKind.external, 1, ''), // 240501
  tkGetDataFail(24, ErrKind.external, 2, ''), // 240502
  tkDbFail(24, ErrKind.external, 3, ''), // 240503
  tkSignFail(24, ErrKind.external, 4, ''), // 240504
  tkCreateAccFail(24, ErrKind.external, 5, ''), // 240505
  tkDeleteOrgFail(24, ErrKind.external, 6, ''); // 240506

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
