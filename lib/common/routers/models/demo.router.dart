import 'package:flutter_start/common/routers/index.dart';
import 'package:flutter_start/pages/demo/amap/index.dart';
import 'package:flutter_start/pages/demo/amap/view_location.dart';
import 'package:flutter_start/pages/demo/amap/view_map.dart';
import 'package:flutter_start/pages/demo/az_list_view/index.dart';
import 'package:flutter_start/pages/demo/bottom_sheet/index.dart';
import 'package:flutter_start/pages/demo/code_input_filed/index.dart';
import 'package:flutter_start/pages/demo/date_time_picker/index.dart';
import 'package:flutter_start/pages/demo/dialog/index.dart';
import 'package:flutter_start/pages/demo/dropdown_menu/index.dart';
import 'package:flutter_start/pages/demo/form_validate/index.dart';
import 'package:flutter_start/pages/demo/permission/index.dart';
import 'package:flutter_start/pages/demo/popover/bindings.dart';
import 'package:flutter_start/pages/demo/popover/view.dart';
import 'package:flutter_start/pages/demo/popup/index.dart';
import 'package:flutter_start/pages/demo/request/index.dart';
import 'package:flutter_start/pages/demo/shares/index.dart';
import 'package:flutter_start/pages/demo/skeleton/index.dart';
import 'package:flutter_start/pages/demo/slidable/index.dart';
import 'package:flutter_start/pages/demo/system_func/index.dart';
import 'package:flutter_start/pages/demo/vibration/index.dart';
import 'package:flutter_start/pages/demo/watermark/index.dart';
import 'package:flutter_start/pages/demo/wechat/post/index.dart';
import 'package:flutter_start/pages/demo/wechat/timeline/index.dart';
import 'package:get/get.dart';

List<GetPage> demoRoutes = [
  GetPage(
    name: AppRoutes.DEMO_PERMISSION,
    title: '权限申请',
    page: () => const PermissionPage(),
    binding: PermissionBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_REQUEST,
    title: '网络请求',
    page: () => const RequestPage(),
    binding: RequestBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_WECHAT_TIMELINE,
    title: '朋友圈',
    page: () => const WechatTimelinePage(),
    binding: WechatTimelineBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_WECHAT_ASSETS_PICKER,
    title: '发表',
    page: () => const WechatPostPage(),
    binding: WechatPostBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_BOTTOM_SHEET,
    title: 'BottomSheet',
    page: () => const BottomSheetPage(),
    binding: BottomSheetBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_DIALOG,
    title: '弹窗',
    page: () => const DialogPage(),
    binding: DialogBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_POPUP,
    title: 'Popup 弹出层',
    page: () => const PopupPage(),
    binding: PopupBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_DROPDOWN_MENU,
    title: '下拉框',
    page: () => const DropdownPage(),
    binding: DropdownBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_CODE_INPUT_FILED,
    title: '验证码输入框',
    page: () => const CodeInputPage(),
    binding: CodeInputBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_SKELETON,
    title: '骨架屏',
    page: () => const SkeletonPage(),
    binding: SkeletonBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_SKELETON_LIST_VIEW,
    title: '骨架屏-listVIew',
    page: () => const SkeletonListViewPage(),
    binding: SkeletonBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_AMAP_ENTRY,
    title: '高德地图入口',
    page: () => const AMapViewPage(),
    binding: AMapBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_AMAP_LOCATION,
    title: '高德地图-定位示例',
    page: () => const AMapLocationViewPage(),
    binding: AMapBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_AMAP_MAP,
    title: '高德地图-地图示例',
    page: () => const AMapMapViewPage(),
    binding: AMapBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_SHARES,
    title: '分享示例',
    page: () => const ShareDemoPage(),
    binding: ShareDemoBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_WATERMARK,
    title: '水印示例',
    page: () => const WatermarkPage(),
    binding: WatermarkBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_SYSTEM_FUNC,
    title: '系统能力',
    page: () => const SystemFuncPage(),
    binding: SystemFuncBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_FORM_VALIDATE,
    title: '表单验证',
    page: () => const FormValidatePage(),
    binding: FormValidateBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_VIBRATION,
    title: '振动',
    page: () => const VibrationPage(),
    binding: VibrationBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_DATE_TIME_PICKER,
    title: '时间日期选择器',
    page: () => const DemoDateTimePickerPage(),
    binding: DemoDateTimePickerBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_POPOVER,
    title: '气泡弹窗',
    page: () => const DemoPopoverPage(),
    binding: DemoPopoverBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_AZ_LIST_VIEW,
    title: '索引列表',
    page: () => const AZListViewDemoPage(),
    binding: AZListViewDemoBinding(),
  ),
  GetPage(
    name: AppRoutes.DEMO_SLIDABLE,
    title: '侧滑菜单',
    page: () => const DemoSlidablePage(),
    binding: DemoSlidableBinding(),
  ),
];
