import 'package:flutter/material.dart';
import 'package:flutter_vant/component/badge.dart';
import 'package:flutter_vant/component/button.dart';
import 'package:flutter_vant/component/toast.dart';
import 'package:rlstyles/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  renderBody() {
    return Scaffold(body: view());
  }

  View view() {
    return View(
      styles: {
        CssRule.justifyContent: 'center',
        CssRule.alignItems: 'center',
        CssRule.backgroundColor: 'red',
        CssRule.flexDirection: 'row',
        CssRule.width: double.infinity,
        CssRule.height: double.infinity
      },
      children: [vanBadge()],
    );
  }

  VanBadge vanBadge() {
    return VanBadge(size: 150, child: vanButton());
  }

  VanButton vanButton() {
    return VanButton(
      icon: Icons.sanitizer,
      loading: false,
      onClick: () {
        print('测试');
      },
      text: '测试6123131231',
    );
  }

  renderView() {
    return this.renderBody();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        allowFontScaling: false,
        builder: () => MaterialApp(home: this.renderView()));
  }
}
