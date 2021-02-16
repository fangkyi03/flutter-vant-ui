import 'package:flutter/material.dart';
import 'package:flutter_vant/component/actionSheet.dart';
import 'package:flutter_vant/component/button.dart';
import 'package:flutter_vant/component/calendar.dart';
import 'package:flutter_vant/component/icon.dart';
import 'package:flutter_vant/component/popup.dart';
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

  getStyle() {
    return {
      'main':{
        // CssRule.justifyContent:'center',
        // CssRule.alignItems:'center',
        CssRule.paddingTop:50,
        CssRule.width:double.infinity,
        CssRule.height:double.infinity
      }
    };
  }

  onClick() {
    VanCalendar.show(context: context,option: VanCalendarOption(
      title: '日历',
      showConfirm: false
    ));
    // Toast.loading(context, VanToastOption(
    //   message: '测试',
    //   position: VanToastPosition.top,
    // ));
    // Toast(context: context,option: VanToastOption(message: '测试',type: VanToastType.fail));
    // VanActionSheet.show(context:context,option:VanActionSheetOption(
    //   round: true,
    //   description: '描述信息测试',
    //   cancelText:'取消测试',
    //   actions: [
    //     VanActionSheetAction(name: '测试1'),
    //     VanActionSheetAction(name: '测试2'),
    //     VanActionSheetAction(name: '测试3')
    //   ],
    // ));
    // VanPopup.show(context: context,option: VanPopupOption(
    //   round: true,
    //   position: 'bottom',
    //   title:'测试',
    //   child: TextView('测试')
    // ));   
    // VanNotify(context: context,option: VanNotifyOption(message: '测试',type: 'danger'));
  }

  renderBody() {
    return Scaffold(body: View(
      styles: getStyle()['main'],
      children: [
        VanButton(text: '点击打开pop',onClick: onClick),
        View(
          styles: {
            CssRule.height:700,
            CssRule.width:400
          },
          children: [
            VanCalendar(option: VanCalendarOption(title: '日历1',showConfirm: true))
          ],
        )
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
