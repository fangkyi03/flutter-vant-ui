import 'package:flutter/material.dart';
import 'package:flutter_vant/component/badge.dart';
import 'package:flutter_vant/component/button.dart';
import 'package:flutter_vant/component/icon.dart';
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
  int num = 98;
  getStyle() {
    return {
      'main': {
        CssRule.flexDirection: 'row',
        CssRule.alignItems: 'center',
        CssRule.justifyContent: 'center',
        CssRule.height: 500,
        CssRule.width: 300,
        CssRule.display: 'flex',
        CssRule.position: 'rel',
        CssRule.paddingTop: 80.0
      }
    };
  }

  onShowLoading() {
    Toast(
        context: context,
        option: VanToastOption(message: '测试111', type: VanToastType.success));
    this.setState(() {
      num = num + 1;
    });
  }

  renderBody() {
    return Scaffold(
        body: Column(
      children: [
        VanBadge(
            child: VanButton(
          onClick: () {
            print('测试');
          },
          text: '测试6',
        ))
      ],
    ));
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
