import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

import 'pages/dialog_page.dart';
import 'pages/lifecycle_test_page.dart';
import 'pages/main_page.dart';
import 'pages/simple_page.dart';

void main() {
  ///添加全局生命周期监听类
  PageVisibilityBinding.instance.addGlobalObserver(AppLifecycleObserver());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static Map<String, FlutterBoostRouteFactory> routerMap = {
    ///flutter主功能展示页面
    'mainPage': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) {
            Map<String, Object> map = settings.arguments;
            String data = map['data'];
            return MainPage(
              data: data,
            );
          });
    },
    'simplePage': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) {
            Map<String, Object> map = settings.arguments;
            String data = map['data'];
            return SimplePage(
              data: data,
            );
          });
    },

    ///生命周期例子页面
    'lifecyclePage': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings, pageBuilder: (_, __, ___) => LifecycleTestPage());
    },

    ///透明弹窗页面
    'dialogPage': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(

          ///透明弹窗页面这个需要是false
          opaque: false,

          ///背景蒙版颜色
          barrierColor: Colors.black12,
          settings: settings,
          pageBuilder: (_, __, ___) => DialogPage());
    },
  };

  Route<dynamic> routeFactory(RouteSettings settings, String uniqueId) {
    FlutterBoostRouteFactory func = routerMap[settings.name];
    if (func == null) {
      return null;
    }
    return func(settings, uniqueId);
  }

  Widget appBuilder(Widget home) {
    return MaterialApp(home: home, debugShowCheckedModeBanner: false);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterBoostApp(
      routeFactory,
      appBuilder: appBuilder,
    );
  }
}