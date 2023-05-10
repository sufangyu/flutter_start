/// APP 更新检查 请求
class AppUpdateRequestEntity {
  late final String device;
  late final String channel;
  late final String architecture;
  late final String model;

  AppUpdateRequestEntity({
    required this.device,
    required this.channel,
    required this.architecture,
    required this.model,
  });

  AppUpdateRequestEntity.fromJson(Map<String, dynamic> json) {
    device = json['device'];
    channel = json['channel'];
    architecture = json['architecture'];
    model = json['model'];
  }

  Map<String, dynamic> toJson() => {
        "device": device,
        "channel": channel,
        "architecture": architecture,
        "model": model,
      };
}

/// APP 更新检查 响应
class AppUpdateResponseEntity {
  AppUpdateResponseEntity({
    required this.shopUrl,
    required this.fileUrl,
    required this.latestVersion,
    required this.latestDescription,
  });
  late final String shopUrl;
  late final String fileUrl;
  late final String latestVersion;
  late final String latestDescription;

  AppUpdateResponseEntity.fromJson(Map<String, dynamic> json) {
    shopUrl = json['shopUrl'];
    fileUrl = json['fileUrl'];
    latestVersion = json['latestVersion'];
    latestDescription = json['latestDescription'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['shopUrl'] = shopUrl;
    data['fileUrl'] = fileUrl;
    data['latestVersion'] = latestVersion;
    data['latestDescription'] = latestDescription;
    return data;
  }
}
