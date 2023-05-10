import 'package:flutter/material.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'controller.dart';

class PermissionPage extends GetView<PermissionController> {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('应用权限申请'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.mic)),
            title: const Text("获取麦克风权限"),
            onTap: () async {
              PermissionUtil.checkPermission(
                permissions: [Permission.microphone],
                onFailed: () => toastInfo(msg: "权限获取失败"),
                onSuccess: () => toastInfo(msg: "权限获取成功"),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.camera_alt)),
            title: const Text("获取相机权限"),
            onTap: () async {
              PermissionUtil.checkPermission(
                permissions: [Permission.camera],
                onFailed: () => toastInfo(msg: "权限获取失败"),
                onSuccess: () => toastInfo(msg: "权限获取成功"),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.folder)),
            title: const Text("获取存储权限"),
            onTap: () async {
              PermissionStatus status =
                  await PermissionUtil.getSinglePermission(Permission.storage);
              LoggerUtil.info("Permission.storage status::$status");

              PermissionUtil.checkPermission(
                permissions: [Permission.storage],
                onFailed: () => toastInfo(msg: "权限获取失败"),
                onSuccess: () => toastInfo(msg: "权限获取成功"),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.photo)),
            title: const Text("获取照片和视频权限"),
            onTap: () async {
              PermissionUtil.checkPermission(
                permissions: [Permission.photos],
                onFailed: () => toastInfo(msg: "权限获取失败"),
                onSuccess: () => toastInfo(msg: "权限获取成功"),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.location_on)),
            title: const Text("获取位置信息权限"),
            onTap: () async {
              PermissionUtil.checkPermission(
                permissions: [Permission.location],
                onFailed: () => toastInfo(msg: "权限获取失败"),
                onSuccess: () => toastInfo(msg: "权限获取成功"),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.location_on)),
            title: const Text("获取位置信息权限（iOS）"),
            onTap: () async {
              PermissionUtil.checkLocationAlways(
                onFailed: () => toastInfo(msg: "权限获取失败"),
                onSuccess: () => toastInfo(msg: "权限获取成功"),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.all_inbox)),
            title: const Text("全部权限"),
            onTap: () async {
              PermissionUtil.checkPermission(
                permissions: [
                  Permission.microphone,
                  Permission.camera,
                  Permission.storage,
                ],
                onFailed: () => toastInfo(msg: "权限获取失败"),
                onSuccess: () => toastInfo(msg: "权限获取成功"),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
