# flutter_create_view
根据页面模版快速初始化页面命令。

## 使用指南

1. 配置文件

Add your Flutter Launcher Icons configuration to your pubspec.yaml.
```dart
dev_dependencies:
  flutter_create_view: last version

flutter_create_view:
  base_dir_release_path: "/lib/pages"
  template_dir_release_path: "_template"
```
2. 命令使用
```shell
flutter pub run flutter_create_view --path=[pagePath] --name=[pageName]
```


