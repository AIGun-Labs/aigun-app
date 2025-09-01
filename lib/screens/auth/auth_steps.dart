/// 认证流程步骤枚举
enum AuthStep {
  /// 邮箱输入步骤
  email(0, '邮箱输入'),

  /// 验证码验证步骤
  verifyCode(1, '验证码验证'),

  /// 个人资料步骤
  profile(2, '个人资料'),

  /// 成功完成步骤
  success(3, '完成注册');

  const AuthStep(this.stepIndex, this.description);

  /// 步骤索引
  final int stepIndex;

  /// 步骤描述
  final String description;

  /// 根据索引获取步骤
  static AuthStep fromIndex(int index) {
    return AuthStep.values.firstWhere(
      (step) => step.stepIndex == index,
      orElse: () => AuthStep.email,
    );
  }

  /// 获取下一个步骤
  AuthStep? get next {
    final nextIndex = stepIndex + 1;
    if (nextIndex < AuthStep.values.length) {
      return AuthStep.fromIndex(nextIndex);
    }
    return null;
  }

  /// 获取上一个步骤
  AuthStep? get previous {
    final previousIndex = stepIndex - 1;
    if (previousIndex >= 0) {
      return AuthStep.fromIndex(previousIndex);
    }
    return null;
  }

  /// 是否为第一步
  bool get isFirst => stepIndex == 0;

  /// 是否为最后一步
  bool get isLast => stepIndex == AuthStep.values.length - 1;

  /// 是否为邮箱步骤
  bool get isEmail => this == AuthStep.email;

  /// 是否为验证码步骤
  bool get isVerifyCode => this == AuthStep.verifyCode;

  /// 是否为个人资料步骤
  bool get isProfile => this == AuthStep.profile;

  /// 是否为成功步骤
  bool get isSuccess => this == AuthStep.success;

  /// 获取步骤总数
  static int get totalSteps => AuthStep.values.length;

  /// 获取进度百分比 (0.0 - 1.0)
  double get progress => (stepIndex + 1) / totalSteps;

  @override
  String toString() =>
      'AuthStep.$name(stepIndex: $stepIndex, description: $description)';
}
