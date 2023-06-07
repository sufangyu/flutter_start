import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class FormValidatePage extends GetView<FormValidateController> {
  const FormValidatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('表单验证'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            _buildFormItem(
              label: '用户名',
              required: true,
              child: TextField(
                controller: controller.usernameController,
                decoration: const InputDecoration(
                  isCollapsed: true,
                  hintText: "请输入用户名",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            _buildFormItem(
              label: '密码',
              required: true,
              child: TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "请输入密码",
                  isCollapsed: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            _buildFormItem(
              label: '数量',
              child: TextField(
                controller: controller.numberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "请输入数量",
                  isCollapsed: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            _buildFormItem(
              label: '手机号',
              child: TextField(
                controller: controller.mobileController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "请输入手机号码",
                  isCollapsed: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            _buildFormItem(
              label: '邮箱地址',
              child: TextField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  hintText: "请输入邮箱地址",
                  isCollapsed: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            _buildFormItem(
              label: '送货上门',
              child: Align(
                alignment: Alignment.centerLeft,
                child: Switch(
                  value: true,
                  onChanged: (val) => {},
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ),
            // _buildFormItem(
            //   label: '单选框',
            //   child: Radio(
            //     value: false,
            //     groupValue: null,
            //     onChanged: (val) {},
            //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //     visualDensity: const VisualDensity(
            //       horizontal: -4,
            //       vertical: 0,
            //     ),
            //   ),
            // ),
            _buildFormItem(
              label: '单选框组',
              child: Obx(() {
                return Wrap(
                  children: [
                    for (String item in controller.radioList)
                      SizedBox(
                        // color: Colors.red,
                        width: 84,
                        child: Row(
                          children: [
                            Radio<String>(
                              value: item,
                              groupValue: controller.state.radioListSelected,
                              onChanged: controller.onChangeRadioList,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: const VisualDensity(
                                horizontal: -2,
                                vertical: -4,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => controller.onChangeRadioList(item),
                              child: Text(item),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              }),
            ),
            _buildFormItem(
              label: '复选框',
              child: Container(
                alignment: Alignment.centerLeft,
                child: Checkbox(
                  value: false,
                  onChanged: (value) {},
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                ),
              ),
            ),
            _buildFormItem(
              label: '复选框组',
              child: Obx(() {
                return Wrap(
                  children: [
                    for (var item in controller.checkboxList)
                      SizedBox(
                        // color: Colors.red,
                        width: 84,
                        child: Row(
                          children: [
                            Checkbox(
                              value: controller.state.checkboxListSelected
                                  .contains(item),
                              onChanged: (val) =>
                                  controller.onChangeCheckboxList(val, item),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: const VisualDensity(
                                horizontal: -2,
                                vertical: -4,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                bool isSelected = controller
                                    .state.checkboxListSelected
                                    .contains(item);
                                controller.onChangeCheckboxList(
                                    !isSelected, item);
                              },
                              child: Text(item),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              }),
            ),
            _buildFormItem(
              label: '文件选择',
              child: Container(
                color: Colors.blue[100],
                height: 80,
                child: const Text("TODO"),
              ),
            ),
            _buildFormItem(
              label: '选择器',
              child: Container(
                color: Colors.blue[100],
                height: 40,
                child: const Text("TODO"),
              ),
            ),
            _buildFormItem(
              label: '备注',
              child: TextField(
                controller: controller.remarksController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: "请输入备注",
                  isCollapsed: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.submit,
                child: const Text("确认提交"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormItem({
    required Widget child,
    bool? required = false,
    String? label = '',
    double? labelWidth = 90.0,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: labelWidth,
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              child: Row(
                children: [
                  Text(
                    required == true ? '*' : '-',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: required == true ? Colors.red : Colors.transparent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(label!, style: TextStyle(fontSize: 16.sp)),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.sp),
                child: child,
              ),
            ),
          ],
        ),
        Divider(height: 8.h),
      ],
    );
  }
}
