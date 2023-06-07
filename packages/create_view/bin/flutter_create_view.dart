import 'package:flutter_create_view/create_view.dart';
import 'package:args/args.dart';
import 'package:flutter_create_view/utils.dart';

/// 参考: https://github.com/fluttercommunity/flutter_launcher_icons/blob/master/bin/flutter_launcher_icons.dart

/// TODO:
/// * 设置创建 view 的目录（项目 yml 文件配置. 如果不配置, 则取包所 提供的默认值）
/// * 设置模版（项目 yml 文件配置. 如果不配置, 则取包所 提供的默认值）
Future<void> main(List<String> arguments) async {
  Utils.log('flutter_create_view.dart::arguments->>$arguments');
  // flutter_launcher_icons.createIconsFromArguments(arguments);

  /// 配置要解析的命令行参数
  final ArgParser parser = ArgParser(allowTrailingOptions: true);
  parser
    ..addOption('path', abbr: 'p', help: '创建 view 路径.支持嵌套目录, 如: examples/demo')
    ..addOption('name', abbr: 'n', help: '创建 view 名称, 建议用大驼峰命名规范')
    ..addFlag('version', abbr: 'v', help: '当前版本', negatable: false)
    ..addFlag('help', abbr: 'h', help: '帮助', negatable: false);

  final ArgResults argResults = parser.parse(arguments);

  run(argResults, parser);
}
