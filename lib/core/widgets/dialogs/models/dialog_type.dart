/// 对话框类型枚举
enum DialogType {
  /// 信息对话框
  info,

  /// 警告对话框
  warning,

  /// 错误对话框
  error,

  /// 成功对话框
  success,

  /// 确认对话框
  confirm,

  /// 自定义对话框
  custom,
}

/// 按钮类型枚举
enum DialogActionType {
  /// 主要按钮（实心）
  primary,

  /// 次要按钮（边框）
  secondary,

  /// 文本按钮
  text,
}
