import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ClassNamePage extends GetView<ClassNameController> {
  const ClassNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('app bar'),
      ),
      body: const Placeholder(),
    );
  }
}
