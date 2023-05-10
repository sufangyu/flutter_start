import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class BookmarksPage extends GetView<BookmarksController> {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Bookmarks Page',
          style: TextStyle(fontSize: 26.sp),
        ),
      ),
    );
  }
}
