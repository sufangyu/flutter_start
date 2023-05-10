import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/common/routers/index.dart';
import 'package:get/get.dart';

import 'controller.dart';

class RequestPage extends GetView<RequestController> {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('网络请求'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.swap_horiz),
              label: const Text("切换环境"),
              onPressed: () => Get.toNamed(AppRoutes.DEBUG_SWITCH_ENV),
            ),
          ),
          Divider(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: ElevatedButton(
              onPressed: controller.getObject,
              child: const Text("Get请求"),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: ElevatedButton(
              onPressed: controller.getException,
              child: const Text("Get请求（异常-500）"),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: ElevatedButton(
              onPressed: controller.getResultFail,
              child: const Text("Get请求（业务错误）"),
            ),
          ),
          Obx(
            () => Center(
              heightFactor: 2.h,
              child: Text(
                "用户信息：${controller.user.name}-${controller.user.age}",
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: ElevatedButton(
              onPressed: controller.getList,
              child: const Text("Get请求[数组]"),
            ),
          ),
          Obx(
            () => controller.userList.isEmpty
                ? Center(child: Text("暂无数据", style: TextStyle(fontSize: 18.sp)))
                : Column(
                    children: controller.userList.map<Widget>((it) {
                      return Text(
                        "${it.name} - ${it.age}",
                        style: TextStyle(fontSize: 18.sp),
                      );
                    }).toList(),
                  ),
            // : Text(controller.userList.length.toString()),
          ),
          Divider(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: ElevatedButton(
              onPressed: controller.postCreate,
              child: const Text("Post 请求"),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: ElevatedButton(
              onPressed: controller.upload,
              child: const Text("图片/文件上传"),
            ),
          ),
          const Divider(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.download,
                    child: const Text("文件下载"),
                  ),
                ),
                Row(children: [
                  TextButton(
                      onPressed: controller.cancelDownload,
                      child: const Text("取消")),
                  TextButton(
                    onPressed: controller.deleteFile,
                    child: const Text(
                      "删除",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ]),
                SizedBox(height: 16.h),
                Obx(
                  () => SizedBox(
                    height: 4.h,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey[200],
                      valueColor:
                          const AlwaysStoppedAnimation(Colors.blueAccent),
                      value: controller.downloadRatio,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: ElevatedButton(
              onPressed: controller.delete,
              child: const Text("Delete 请求"),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: ElevatedButton(
              onPressed: controller.put,
              child: const Text("Put 请求"),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            child: ElevatedButton(
              onPressed: controller.patch,
              child: const Text("Patch 请求"),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
