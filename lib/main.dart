import 'package:flutter/material.dart';
import 'package:flutter_vant/component/actionSheet.dart';
import 'package:flutter_vant/component/button.dart';
import 'package:flutter_vant/component/calendar.dart';
import 'package:flutter_vant/component/notify.dart';
import 'package:flutter_vant/component/passwordInput.dart';
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

  List<String> mSelect = [];
  getStyle() {
    return {
      'main':{
        // CssRule.justifyContent:'center',
        // CssRule.alignItems:'center',
        CssRule.paddingTop:50,
        CssRule.width:double.infinity,
        CssRule.height:double.infinity,
        CssRule.backgroundColor:'#f8f8f8'
      }
    };
  }

  onConfirm(List<String> select) {
    setState(() {
      mSelect = select;      
    });
  }

  onSelect(List<String> select) {
    print('点击');
  }

  onCalendar() {
    VanCalendar.show(context: context,option: VanCalendarOption(
      title: '日历',
      onConfirm: onConfirm,
      onSelect: onSelect,
      rangColor: 'rgba(238,10,36,0.1)',
      // type: 'asdasd',
      // type: VanCalendarType.range,
      // defaultDate: mSelect,
      // defaultDate: ['2021-03-28','2021-04-01'],
      confirmText: '点击确定'
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
  }

  onNotify() {
    VanNotify(
      context: context,
      option: VanNotifyOption(
        message: '测试',
        type: VanNotifyType.primary
      )
    );
  }

  renderBody() {
    return Scaffold(body: View(
      styles: getStyle()['main'],
      children: [
        VanPasswordInput(
          value: '123',
          gutter: 1,
          length: 6,
          mask: false,
        ),
        VanButton(text: '点击打开notify',onClick: onNotify,block: true),
        VanButton(text: '点击打开日历',onClick: onCalendar,block: true),
        View(
          styles: {
            CssRule.height:500,
            CssRule.width:400,
            CssRule.paddingBottom:40
          },
          children: [
            VanCalendar(option: VanCalendarOption(
              title: '日历1',
              showConfirm: true,
              type: VanCalendarType.range,
              rangColor: 'rgba(238,10,36,0.1)',
              onConfirm: (List<String> list){
                Toast(
                  context: context,
                  option: VanToastOption(
                    type: VanToastType.fail,
                    message: '当前选择日期' + list.toString()
                  )
                );
              }
            ))
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
