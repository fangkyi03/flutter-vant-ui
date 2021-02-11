import 'package:flutter/material.dart';
import 'package:flutter_vant/component/overlay.dart';
import 'package:rlstyles/Component/CssRule.dart';
import 'package:rlstyles/Component/TextView.dart';
import 'package:rlstyles/Component/View.dart';

class VanPopupOption {
  // 弹出样式
  final Map<String,dynamic> overlayStyle;
  // 是否圆角
  final bool round;
  // 是否显示遮罩层
  final bool overlay;
  // 是否在点击遮罩层后关闭	
  final bool closeClickOverlay;
  // 是否开启底部安全区适配 
  final bool safeAreaInsetBottom;
  // 显示位置
  final String position;
  // 子元素
  final Widget child;
  // 是否显示头部
  final bool isShowHeader;
  const VanPopupOption({
    this.position = 'left',
    this.child,
    this.isShowHeader = true,
    this.overlay = false,
    this.safeAreaInsetBottom = false,
    this.round = false,
    this.closeClickOverlay = true,
    this.overlayStyle = const {},
  });
}

class VanPopup extends StatefulWidget {

  final VanPopupOption option;
  VanPopup({
    this.option = const VanPopupOption()
  });
  @override
  _VanPopupState createState() => _VanPopupState();

  static show({BuildContext context,VanPopupOption option}) {
    VanOverlay.show(context:context,child: VanPopup(option: option));
  }

  static remove() {
    VanOverlay.remove();
  }

}

class _VanPopupState extends State<VanPopup> {

  getStyle() {
    return {
      'main':{
        CssRule.width:double.infinity,
        CssRule.height:double.infinity,
        CssRule.backgroundColor:'rgba(0, 0, 0, 0.7)',
      },
      'header':{
        CssRule.height:40,
        CssRule.width:double.infinity,
        CssRule.flexDirection:'row',
        CssRule.alignItems:'center',
        CssRule.justifyContent:'center',
      },
      'header-close':{
        CssRule.position:'abs',
        CssRule.right:0,
        CssRule.top:0,
        CssRule.bottom:0,
        CssRule.width:30,
        CssRule.alignItems:'center',
        CssRule.justifyContent:'center'
      },
      'pop-left':{
        CssRule.position:'abs',
        CssRule.left:0,
        CssRule.top:0,
        CssRule.bottom:0,
        CssRule.backgroundColor:'white',
        CssRule.width:200,
        CssRule.borderRadius:0,
        ...widget.option.overlayStyle
      },
      'pop-right':{
        CssRule.position:'abs',
        CssRule.right:0,
        CssRule.top:0,
        CssRule.bottom:0,
        CssRule.backgroundColor:'white',
        CssRule.width:200,
        CssRule.borderRadius:0,
        ...widget.option.overlayStyle
      },
      'pop-top':{
        CssRule.position:'abs',
        CssRule.right:0,
        CssRule.left:0,
        CssRule.top:0,
        CssRule.backgroundColor:'white',
        CssRule.minHeight:200,
        CssRule.borderRadius:0,
        ...widget.option.overlayStyle
      },
      'pop-bottom':{
        CssRule.position:'abs',
        CssRule.right:0,
        CssRule.left:0,
        CssRule.bottom:0,
        CssRule.backgroundColor:'white',
        CssRule.borderTopLeftRadius:widget.option.round ? 15 : 0,
        CssRule.borderTopRightRadius: widget.option.round ? 15 : 0,
        CssRule.minHeight:200,
        ...widget.option.overlayStyle
      }
    };
  }

  renderHeaderClose() {
    return View(
      styles: getStyle()['header-close'],
      onClick: onCancel,
      children: [
        Icon(Icons.close,size: 20,color: Colors.black)
      ]
    );
  }

  renderHeader() {
    if (widget.option.isShowHeader == null ||  widget.option.isShowHeader == false) return Container(); 
    return View(
      styles: getStyle()['header'],
      children: [
        renderHeaderClose(),
        TextView('标题')
      ]
    );
  }

  
  renderPop() {
    return View(
      styles: getStyle()['pop-${widget.option.position}'],
      onClick: (){
        print('pop');
      },
      children: [
        renderHeader(),
        widget.option.child ?? Container()
      ],
    );
  }

  onCancel() {
    if (widget.option.closeClickOverlay) {
      VanOverlay.remove();
    }
  }

  renderMain() {
    return View(
      styles: getStyle()['main'],
      onClick: onCancel,
      children: [
        renderPop()
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return renderMain();
  }
}