import 'package:flutter/material.dart';
import 'package:flutter_vant/component/cell.dart';
import 'package:flutter_vant/component/cellGroup.dart';
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

  getStyle() {
    return {
      'main':{
        CssRule.justifyContent:'center',
        CssRule.alignItems:'center'
      }
    };
  }

  renderBody() {
    return Scaffold(body: View(
      styles: getStyle()['main'],
      children: [
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
