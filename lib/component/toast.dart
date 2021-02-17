import 'package:flutter/material.dart';
import 'package:flutter_vant/component/icon.dart';
import 'package:rlstyles/Component/CssRule.dart';
import 'package:rlstyles/Component/StylesMap.dart';
import 'package:rlstyles/Component/TextView.dart';
import 'package:rlstyles/Component/View.dart';
import 'package:rlstyles/main.dart';

enum VanToastType {
  success,
  fail,
  loading,
  html,
}

enum VanToastPosition { 
  top, 
  middle,
  bottom
}

class VanToastOption {
  // 图标
  final dynamic icon;
  // 提示消息
  final String message;
  // 提示类型
  VanToastType type;
  // 提示延迟
  final Duration duration;
  // 提示位置
  final VanToastPosition position;
  // 是否显示遮挡
  final bool overlay;
  // 完全展示后的回调函数
  final dynamic onOpened;
  // 关闭时的回调函数
  final dynamic onClose;
  // 是否在点击遮罩层后关闭
  final bool closeOnClickOverlay;
  // 样式
  final Map<String,dynamic> className;
  VanToastOption({
    this.icon,
    this.message,
    this.type,
    this.className = const {},
    this.duration = const Duration(milliseconds: 2000),
    this.position = VanToastPosition.middle,
    this.overlay,
    this.onOpened,
    this.onClose,
    this.closeOnClickOverlay,
  });
}

class Toast {
  static OverlayEntry _overlayEntry; //toast靠它加到屏幕上
  static bool _showing = false; //toast是否正在showing
  static DateTime _startedTime; //开启一个新toast的当前时间，用于对比是否已经展示了足够时间
  static VanToastOption _option;
  Toast({BuildContext context, VanToastOption option}) {
    createToast(context, option);
  }

  static getStyles() {
    return {
      'main':{
        CssRule.width:double.infinity,
        CssRule.height:double.infinity,
        CssRule.backgroundColor:_option.overlay == true ? 'rgba(0, 0, 0, 0.7)': '',
        ..._option.className
      },
      'toast':{
        CssRule.width:120,
        CssRule.maxHeight:120,
        CssRule.backgroundColor:'rgba(0, 0, 0, 0.7)',
        CssRule.borderRadius:5,
        CssRule.justifyContent:'center',
        CssRule.alignItems:'center',
        CssRule.color:'white',
        CssRule.padding:5,
        CssRule.fontSize:12
      },
      'middle':{
        CssRule.justifyContent:'center',
        CssRule.alignItems:'center'
      },
      'top':{
        CssRule.alignItems:'center',
        CssRule.paddingTop:50
      },
      'bottom':{
        CssRule.justifyContent:'flex-end',
        CssRule.alignItems:'center',
        CssRule.paddingBottom:50
      }
    };
  }

  static renderLoading() {
    return View(
      styles: {
        CssRule.marginBottom:5
      },
      children: [
        SizedBox(
          width: getSize(size: 20),
          height: getSize(size: 20),
          child: CircularProgressIndicator(
            strokeWidth: 1,
            valueColor: AlwaysStoppedAnimation(Colors.white))
        )
      ],
    );
  }

  static renderToast() {
    return View(
      styles: getStyles()['toast'],
      children: [
        _option.type != VanToastType.loading ? getIcon() : renderLoading(),
        TextView(_option.message),
      ],
    );
  }

  static getPositionName() {
    return ['top','middle','bottom'][_option.position.index];
  }

  static Widget renderOverlay(BuildContext context) {
    final css = {
      'main':true,
      getPositionName():true
    };
    final cls = StylesMap.getClass(css, getStyles());
    return View(
      styles: cls,
      children: [
        AnimatedOpacity(
          opacity: _showing ? 1.0 : 0.0, 
          duration: _showing ? Duration(milliseconds: 100) : Duration(milliseconds: 400),
          child: renderToast()
        )
      ]
    );
  }

  static IconData getIconName() {
    switch (_option.type) {
      case VanToastType.success:
        return Icons.done;
      case VanToastType.fail:
        return Icons.error_outline;
      default:
        return Icons.done;
    }
  }

  static getIcon() {
    if (_option.icon != null) {
      return VanIcon(
        name: _option.icon,
        color: 'white',
        className: {
          CssRule.marginBottom:5
        }
      );
    }else if (_option.type != null){
      return VanIcon(
        name: getIconName(),
        color: 'white',
        className: {
          CssRule.marginBottom:5
        }
      );
    }else {
      return Container();
    }
  }

  static createToast(BuildContext context, VanToastOption option) async {
    _option = option;
    assert(option.message != null);
    _startedTime = DateTime.now();
    OverlayState overlayState = Overlay.of(context);
    _showing = true;
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(builder: renderOverlay);
      overlayState.insert(_overlayEntry);
    } else {
      _overlayEntry.markNeedsBuild();
    }
    await Future.delayed(Duration(milliseconds: 2000)); //等待两秒
    if (DateTime.now().difference(_startedTime).inMilliseconds >= 2000) {
      _showing = false;
      _overlayEntry.markNeedsBuild();
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }

  static fail(BuildContext context,VanToastOption option) {
    option.type = VanToastType.fail;
    createToast(context, option);
  }

  static success(BuildContext context,VanToastOption option) {
    option.type = VanToastType.success;
    createToast(context, option);
  }

  static loading(BuildContext context,VanToastOption option) {
    option.type = VanToastType.loading;
    createToast(context, option);
  }
}
