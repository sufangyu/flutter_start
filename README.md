# flutter_start

A new Flutter project.

## 问题解决

### dio 报错
- 报错：[DioErrorType.other]: SocketException: Connection refused (OS Error: Connection refused, errno = 111), address = localhost, port = 59528
- 方案：在文件 android/app/src/main/AndroidManifest.xml 增加配置 `android:usesCleartextTraffic="true"`
```xml
<application
        android:usesCleartextTraffic="true"
        >
        
</application>
```