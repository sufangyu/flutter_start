import 'package:flutter/material.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_start/common/langs/translation_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

import 'common/routers/index.dart';
import 'common/store/index.dart';
import 'common/style/index.dart';
import 'global.dart';

Future<void> main() async {
  // await Global.init();
  // runApp(const MyApp());

  FlutterBugly.postCatchedException(
    () async {
      // 如果需要 ensureInitialized，请在这里运行。
      // WidgetsFlutterBinding.ensureInitialized();
      await Global.init();
      runApp(const MyApp());
      FlutterBugly.init(
        androidAppId: "4aaf7c60eb",
        iOSAppId: "206790fb8a",
      );
    },
    onException: (FlutterErrorDetails details) {
      debugPrint("onException::${details.toString()}");
    },
    debugUpload: true,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? widget) => RefreshConfiguration(
        headerBuilder: () => const ClassicHeader(
          idleText: '下拉刷新',
          releaseText: '释放立即刷新',
          refreshingText: '加载中...',
          completeText: "刷新成功",
          failedText: "刷新失败",
        ),
        footerBuilder: () => const ClassicFooter(
          loadingText: "正在加载...",
          noDataText: "没有更多了",
          idleText: "上拉加载",
          failedText: "加载失败",
        ),
        hideFooterWhenNotFull: true,
        headerTriggerDistance: 80,
        maxOverScrollExtent: 100,
        footerTriggerDistance: 150,
        child: GetMaterialApp(
          title: 'Flutter示例',
          theme: AppTheme.light,
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          builder: EasyLoading.init(),
          defaultTransition:
              GetPlatform.isIOS ? Transition.native : Transition.cupertino,
          translations: TranslationService(),
          navigatorObservers: [AppPages.observer],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: ConfigStore.to.languages,
          locale: ConfigStore.to.locale,
          fallbackLocale: TranslationService.fallbackLocale,
        ),
      ),
    );
  }
}
