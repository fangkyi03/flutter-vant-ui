import 'package:flutter/material.dart';
import 'package:flutter_vant/component/overlay.dart';
import 'package:rlstyles/Component/CssRule.dart';
import 'package:rlstyles/Component/StylesMap.dart';
import 'package:rlstyles/Component/TextView.dart';
import 'package:rlstyles/Component/View.dart';

class VanNotifyType {
  static const String primary = 'primary';
  static const String success = 'success';
  static const String warning = 'warning';
  static const String danger = 'danger';
}

class VanNotifyOption {
  // 类型，可选值为 primary success warning	
  final String type;
  // 展示文案，支持通过\n换行
  final String message;
  // 字体颜色
  final String color;
  // 背景颜色
  final String background;
  // 自定义类名
  final Map<String,dynamic> className;

  VanNotifyOption({
    this.type = VanNotifyType.success,
    this.message,
    this.color,
    this.background,
    this.className = const {}
  });
}

class VanNotify {

  VanNotifyOption option;
  BuildContext context;
  static VanNotifyOption _option;

  static getStyles() {
    return {
      'main':{

      },
      'body':{
        CssRule.minHeight:36,
        // CssRule.height:36,
        CssRule.width:double.infinity,
        CssRule.justifyContent:'center',
        CssRule.alignItems:'center',
        CssRule.color:'white',
        CssRule.paddingTop:40,
        CssRule.paddingBottom:10,
        ..._option.className
      },
      'success':{
        CssRule.backgroundColor:'#07c160',
      },
      'warning':{
        CssRule.backgroundColor:'#ff976a',
      },
      'danger':{
        CssRule.backgroundColor:'#ee0a24'
      },
      'primary':{
        CssRule.backgroundColor:'#1989fa'
      },
      'default':{
        CssRule.backgroundColor:'white',
        CssRule.color:'black'
      }
    };
  }

  static renderNotify() {
    Map css = {
      'body':true,
      '${_option.type}':true,
    };
    final cls = StylesMap.getClass(css, getStyles());
    return View(
      styles: getStyles()['main'],
      children: [
        View(
          styles: cls,
          children: [
            TextView(_option.message)
          ]
        )
      ],
    );
  }

  VanNotify({this.option,this.context}) {
    _option = this.option;
    VanOverlay.show(context: context,child:renderNotify(),isShowTop: false);      
    Future.delayed(Duration(milliseconds: 2000))
    .then((value) => VanOverlay.remove());     
  }
}