import 'package:flutter/foundation.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:permission_handler/permission_handler.dart';

/// 权限工具类
/// https://www.jianshu.com/p/35b37c012351
/// IOS 权限配置：https://www.jianshu.com/p/650ddfc7d049
///             https://www2.jianshu.com/p/cebd00a7cc16
class PermissionUtil {
  static _showToast(String msg) {
    toastInfo(msg: msg);
  }

  /// 检测是否有权限
  /// [permissionList] 权限申请列表;
  /// [errMsg] 错误提示信息;
  /// [onSuccess] 成功回调;
  /// [onFailed] 失败回调（有一个失败就触发）;
  /// [goSetting] 前往设置;
  static checkPermission({
    required List<Permission> permissions,
    String? errMsg,
    VoidCallback? onSuccess,
    VoidCallback? onFailed,
    VoidCallback? goSetting,
  }) async {
    // 一个新待申请权限列表
    List<Permission> newPermissions = [];
    // 遍历当前权限申请列表
    for (Permission permission in permissions) {
      PermissionStatus status = await permission.status;
      // 如果不是允许状态就添加到新的申请列表中
      if (!status.isGranted) {
        newPermissions.add(permission);
      }
    }

    if (newPermissions.isNotEmpty) {
      // 有需重新申请的权限列表
      PermissionStatus status = await _requestPermission(newPermissions);
      switch (status) {
        // 拒绝状态
        case PermissionStatus.denied:
          onFailed != null ? onFailed() : _showToast(errMsg ?? "权限申请失败");
          break;
        // 允许状态
        case PermissionStatus.granted:
          onSuccess != null ? onSuccess() : _showToast("权限申请成功");
          break;
        // 永久拒绝、活动限制
        case PermissionStatus.restricted:
        case PermissionStatus.limited:
        case PermissionStatus.permanentlyDenied:
          _showToast("已拒绝授权, 需手动设置");
          goSetting != null ? goSetting() : await openAppSettings();
          break;
      }
    } else {
      onSuccess != null ? onSuccess() : _showToast("权限申请成功");
    }
  }

  /// 获取当个权限的状态
  static Future<PermissionStatus> getSinglePermission(
    Permission permission,
  ) async {
    // 获取当前状态
    PermissionStatus status = await permission.status;
    PermissionStatus currentPermissionStatus = PermissionStatus.granted;

    // 如果它状态不是允许那么就去获取
    if (!status.isGranted) {
      currentPermissionStatus = await _requestPermission([permission]);
    }

    // 返回最终状态
    return currentPermissionStatus;
  }

  /// 检测是否有 LocationAlways 权限 (iOS专有)
  /// [errMsg] 错误提示信息;
  /// [onSuccess] 成功回调;
  /// [onFailed] 失败回调;
  /// [goSetting] 前往设置;
  static checkLocationAlways({
    String? errMsg,
    VoidCallback? onSuccess,
    VoidCallback? onFailed,
    VoidCallback? goSetting,
  }) async {
    // 获取前置状态. Android 没有这一步 iOS 会先访问这个再访问其他的
    PermissionStatus status = PermissionStatus.granted;
    status = await getSinglePermission(Permission.locationWhenInUse);

    // 获取第二个状态. 如果前置状态为成功才能执行获取第二个状态
    PermissionStatus status2 = PermissionStatus.denied;
    if (status.isGranted) {
      status2 = await getSinglePermission(Permission.locationAlways);
    }

    // 如果两个都成功那么就返回成功
    if (status.isGranted && status2.isGranted) {
      onSuccess != null ? onSuccess() : _showToast("权限申请成功");
      // 如果有一个拒绝那么就失败了
    } else if (status.isDenied || status2.isDenied) {
      onFailed != null ? onFailed() : _showToast(errMsg ?? "权限申请失败");
    } else {
      _showToast("已拒绝授权, 需手动设置");
      goSetting != null ? goSetting() : await openAppSettings();
    }
  }

  /// 获取新列表中的权限 如果有一项不合格就返回 false
  static Future<PermissionStatus> _requestPermission(
    List<Permission> permissions,
  ) async {
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    PermissionStatus currentPermissionStatus = PermissionStatus.granted;
    statuses.forEach((key, value) {
      if (!value.isGranted) {
        currentPermissionStatus = value;
        return;
      }
    });
    return currentPermissionStatus;
  }

  /// 打开设置
  static Future<void> openSettings() async {
    await openAppSettings();
  }
}
