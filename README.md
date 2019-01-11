# flutter-learn
flutter学习笔记，持续更新

## 优秀的学习资料
1. [flutter官方文档](https://flutter.io/docs)
2. [flutter-study](https://github.com/yang7229693/flutter-study)
3. [Dart官方文档](https://www.dartlang.org/)
4. [Flutter中文网](https://flutterchina.club/)

## 现有Android工程接入flutter module
- [x] 在真实的项目中，我们基本上不会去做一个纯flutter项目，都是在现有的Android工程中拿一个模块来用flutter实现
- [x] flutter官方文档中提供的接入方式：[Add Flutter to existing apps](https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps)

### 新建Flutter module
1. 用命令flutter create新建

```
$ flutter create -t module my_flutter
```
2. 用Android Studio新建

Android Studio->File->New->New Flutter Project->Flutter Module

### 集成到现有工程
#### 以module引用的方式集成
1. 在host app's settings.gradle中添加

```
// MyApp/settings.gradle
include ':app'                                     // assumed existing content
setBinding(new Binding([gradle: this]))                                 // new
evaluate(new File(                                                      // new
  settingsDir.parentFile,                                               // new
  'my_flutter/.android/include_flutter.groovy'                          // new
))       
```

2. 在build.gradle中引用

```
dependencies {
  implementation project(':flutter')
}
```

#### 以aar文件的方式集成
##### 在Flutter module的.android目录中打包aar

```
$ cd .android/
$ ./gradlew flutter:assembleDebug
```

有些时候会遇到问题，这个时候可以尝试在flutter module的根目录下执行：

```
$ flutter clean
$ flutter run
```

##### 引用这个aar

host端app目录下新建目录libs。

app下build.gradle中添加：

```
repositories {
    flatDir {
        dirs 'libs'
    }
}
```
添加dependencies：

```
implementation name: 'flutter-debug', ext: 'aar'
```
从flutter module中拷贝生成的aar到libs目录下。

rebuild，run

十有八九会crash并且报错：

```
A/flutter: [FATAL:flutter/fml/icu_util.cc(95)] Check failed: context->IsValid(). Must be able to initialize the ICU context. Tried: /data/user/0/com.example.androidwithflutter3/app_flutter/icudtl.dat
A/libc: Fatal signal 6 (SIGABRT), code -6 in tid 21199 (oidwithflutter3)
```

原因就是文件icudtl.dat没有引进来（不得不说，flutter坑真多），解决方法：
1. 新建assets目录并把icudtl.dat拷进来，注意路径是：assets/flutter_shared/icudtl.dat
2. 可以在flutter.jar中找到这个文件

关于这个坑更多的描述，参见：[#18025](https://github.com/flutter/flutter/issues/18025)

完成之后就可以run起来了。


#### 以远程仓库aar的方式集成

1. 在Flutter module的.android目录中打包aar并上传仓库
2. 引用这个远程aar

### 宿主端调用
宿主端Android APP可以通过route的方式调用flutter module中的内容，例如，Android端可以新建一个Activity来承载flutter。

```
public class FlutterViewActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        View flutterView = Flutter.createView(
                FlutterViewActivity.this,
                getLifecycle(),
                "route"
        );
        setContentView(flutterView);
    }
}
```

也可以通过Fragment的形式来承载flutter

```
public class FlutterFragmentActivity extends FragmentActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_fm);
        getSupportFragmentManager()
                .beginTransaction()
                .add(R.id.fragment_container, Flutter.createFragment("route"))
                .commit();
    }
}
```

在flutter module中，需要实现路由

```
void main() => runApp(_widgetForRoute(window.defaultRouteName));

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'demo_app':
      return MyApp();
    case 'version':
      return VersionPage();
    default:
      return ErrorPage('Unknown route: $route');
  }
}
```

## Flutter Plugin
关于这个主题的官方文档地址：[Developing packages & plugins](https://flutter.io/docs/development/packages-and-plugins/developing-packages)

Android Studio IDE下的File/New/New Flutter Project选项下自带了四种模板：

- Flutter Application： Flutter应用
- Flutter Plugin：Flutter插件
- Flutter Package：纯Dart组件
- Flutter Module：Flutter模块

Flutter Plugin提供Android或者iOS的底层封装，在Flutter层提供组件功能，使Flutter层可以较方便的调用Android或者IOS层提供的接口。很多平台相关性或者对于Flutter实现起来比较复杂的部分，都可以封装成Plugin。

Flutter Plugin通信的原理图如下：

![image](/resources/imgs/flutter_plugin1.png)

Dart层和平台层（Android&IOS）通过MethodChannel实现通信和调用。

### 新建Flutter Plugin
在Android Studio IDE下的File/New/New Flutter Project选项下选择模板Flutter Plugin，就可以新建一个Flutter Plugin。

新建的Flutter Plugin有以下主要部分：
- [x] android：android侧的插件代码
- [x] ios：ios侧的插件代码
- [x] lib：插件Dart代码
- [x] pubspec.yaml：插件配置文件
- [x] example：使用插件的flutter示例工程

### Plugin的平台侧分析
Android侧java层的Plugin实现类，都会继承MethodCallHandler接口，在方法onMethodCall中实现对flutter层调用的分发，如：

```
@Override
public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals(GET_PLATFORM_VERSION)) {
        result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals(GET_SDK_INT)) {
        result.success("Android SDK: " + android.os.Build.VERSION.SDK_INT);
    } else {
        result.notImplemented();
    }
}
```

而这个插件类被注册并暴露给flutter层，则是通过一个static方法：

```
public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), PLUGIN_NAME);
    channel.setMethodCallHandler(new FlutterPlugin());
}
```

这个插件是什么时候被注册的呢，在插件调用示例的example flutter工程的MainActivity中，我们可以看到在onCreate有这样一行代码：

```
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
}
```

GeneratedPluginRegistrant类是自动生成的插件注册类：

```
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    FlutterPlugin.registerWith(registry.registrarFor("com.jeremyliao.flutterplugin.FlutterPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
```

在此处完成了插件的注册。

### Plugin的flutter侧分析
lib下的代码就是flutter侧的实现，比如demo中的这个flutter_plugin.dart，本质上就是把平台侧的接口重新封装了一下，提供给其他dart使用：

```
class FlutterPlugin {
  static const MethodChannel _channel = const MethodChannel('flutter_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get sdkInt async {
    final String version = await _channel.invokeMethod('getSdkInt');
    return version;
  }
}
```

### 发布
插件开发完毕，可以发布插件让其他人使用，在发布之前，确保pubspec.yaml,、README.md以及CHANGELOG.md文件的内容都正确填写完毕。可以通过dry-run命令来看准备是否就绪。

```
flutter packages pub publish --dry-run
```

检查无误后，可以执行下面的命令，发布到[Dart packages](https://pub.dartlang.org/)

```
flutter packages pub publish
```

### 在flutter工程中引用插件
#### 引用发布的库
在dependencies加上我们需要引入的库，例如引入url_launcher库：

```
dependencies:
  url_launcher: ^0.4.2
```

#### 引用未发布的库
##### 基于Path的引用

```
dependencies:
  flutter_plugin:
    path: ../
```

##### 基于Git的引用方式

```
dependencies:
  flutter_plugin:
    git:
      url: git://github.com/flutter/packages.git
      path: packages/package1   
```

### 在flutter层调用
调用是异步的，关键代码如下：

```
Future<void> initPlatformState() async {
    ...
    try {
        platformVersion = await FlutterPlugin.platformVersion;
    } on PlatformException {
        platformVersion = 'Failed to get platform version.';
    }
    ...
}
```
