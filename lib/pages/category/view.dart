import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'widgets/index.dart';

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: NewsPageList(),
      ),
    );
  }
}
