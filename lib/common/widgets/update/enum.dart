enum InstallStatus {
  normal(value: 0, label: "立即更新"),
  downing(value: 1, label: "下载中"),
  downFinish(value: 2, label: "下载完成"),
  downFail(value: 3, label: "下载失败"),
  installFail(value: -1, label: "安装失败");

  /// 值
  final int value;

  /// 文本描述
  final String label;

  const InstallStatus({
    required this.value,
    required this.label,
  });
}
