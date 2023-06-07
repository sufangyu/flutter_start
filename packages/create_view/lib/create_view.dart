import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:args/args.dart';
import 'package:flutter_create_view/utils.dart';
import 'package:settings_yaml/settings_yaml.dart';

Future<void> run(ArgResults argResults, ArgParser parser) async {
  /// 帮助提示
  if (argResults['help']) {
    stdout.writeln('创建 View 初始化文件');
    stdout.writeln(parser.usage);
    exit(0);
  }

  /// 创建名称
  String? path = argResults['path'];
  String? name = argResults['name'];

  if (path == null || path == '') {
    stdout.writeln('View 名称不能为空, 可通过 --path=[viewName] 设置');
    exit(2);
  }

  // 当前目前路径 cwd
  String currentPath = Directory.current.path;
  var settings = SettingsYaml.load(pathToSettings: '$currentPath/pubspec.yaml');
  var config = settings['flutter_create_view'];
  var baseDirReleasePath = config['base_dir_release_path'] as String;
  var tempDirReleasePath = config['template_dir_release_path'] as String;
  // print('$baseDirReleasePath, $tempDirReleasePath');
  String baseDir = "$currentPath$baseDirReleasePath";
  String templateDir = "$currentPath$tempDirReleasePath";

  // 创建页面路径
  Directory viewDir = Directory("$baseDir/$path");

  List<String> pathList = path.split('/');
  String viewName = name ?? pathList.last;
  bool exist = viewDir.existsSync();

  if (exist) {
    stdout.writeln("页面 $path 已存在");
    exit(2);
  }

  createDir(path: path, viewDir: viewDir, baseDir: baseDir, pathList: pathList);
  await copyFileAnReplaceContent(templateDir, viewDir.path, viewName);

  stdout.writeln("页面初始化完成");
  exit(2);
}

/// 创建目录
Future<void> createDir({
  required String path, // view 相对路径（相对 views 跟目录）
  required Directory viewDir, // view 完整路径
  required String baseDir, // views 根目录
  required List<String> pathList,
}) async {
  List<String> createdList = [];
  for (var pathName in pathList) {
    bool isLast = pathList.last == pathName;
    String willCreateDir = p.join(baseDir, createdList.join('/'), pathName);

    Utils.createDir(willCreateDir);
    createdList.add(pathName);

    if (isLast == true) {
      Utils.log("复制文件+修改内容");
    }
  }
}

/// 复制、修改文件内容
Future<void> copyFileAnReplaceContent(
  String tempDir,
  String viewDir,
  String viewName,
) async {
  Stream<FileSystemEntity> fileList = Directory(tempDir).list();
  await for (FileSystemEntity fileSystemEntity in fileList) {
    FileSystemEntityType type =
        FileSystemEntity.typeSync(fileSystemEntity.path);

    if (type == FileSystemEntityType.file &&
        !fileSystemEntity.path.endsWith('.DS_Store')) {
      String fileName = fileSystemEntity.path.split('/').last;
      String className = Utils.transformClassName(viewName);
      // print("fileSystemEntity::$fileSystemEntity, fileName->>$fileName");

      File file = File(fileSystemEntity.path);
      final contents = await file.readAsString();
      String createFilePath = "$viewDir/$fileName";

      File createFile = File(createFilePath);
      await createFile.create(recursive: true);
      await createFile.writeAsString(contents
          .replaceAll('ClassName', className)
          .replaceAll('view_library_name', viewName));
    }
  }
}
