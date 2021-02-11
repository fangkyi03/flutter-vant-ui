import 'package:flutter/material.dart';
import 'package:rlstyles/Component/CssRule.dart';
import 'package:rlstyles/Component/TextView.dart';
import 'package:rlstyles/Component/View.dart';

class VanPopupOption {
  // 弹出样式
  final Map<String,dynamic> overlayStyle;
  // 是否圆角
  final bool round;
  const VanPopupOption({this.overlayStyle = const {},this.round = false});
}

class VanPopup {
  static OverlayState overlayState;
  static OverlayEntry _overlayEntry;
  static VanPopupOption _option;
  static getStyle() {
    return {
      'main':{
        CssRule.width:double.infinity,
        CssRule.height:double.infinity,
        CssRule.backgroundColor:'rgba(0, 0, 0, 0.7)',
      },
      'pop':{
        CssRule.position:'abs',
        CssRule.right:0,
        CssRule.left:0,
        CssRule.bottom:0,
        CssRule.backgroundColor:'white',
        CssRule.borderTopLeftRadius:_option.round ? 15 : 0,
        CssRule.borderTopRightRadius: _option.round ? 15 : 0,
        CssRule.paddingTop:10,
        CssRule.paddingLeft:10,
        CssRule.paddingRight:10,
        CssRule.height:200,
        ..._option.overlayStyle
      }
    };
  }

  static renderPop() {
    return View(
      styles: getStyle()['pop'],
      onClick: (){
        print('pop');
      },
      children: [
        TextView('测试')
      ],
    );
  }

  static renderBk() {
    return View(
      styles: getStyle()['main'],
      onClick: (){
        remove();
      },
      children: [
        renderPop()
      ],
    );
  }

  static show({BuildContext context,VanPopupOption option}) {
    _option = option;
    overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(opaque:false,builder: (BuildContext context )=> renderBk());
    overlayState.insert(_overlayEntry);
  }

  static remove() {
    _overlayEntry.remove();
  }
}