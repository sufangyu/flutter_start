import 'package:flutter/material.dart';
import 'package:flutter_start/common/store/index.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DropdownPage extends GetView<DropdownController> {
  const DropdownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text('sign_in'),
            const Divider(),
            Text(ConfigStore.to.isAlreadyOpen.toString()),
          ],
        ),
      ),
    );
  }
}
