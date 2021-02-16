import 'package:flutter/material.dart';
import 'package:flutter_vant/component/button.dart';
import 'package:flutter_vant/component/overlay.dart';
import 'package:rlstyles/Component/CssRule.dart';
import 'package:rlstyles/Component/TextView.dart';
import 'package:rlstyles/Component/View.dart';
import 'package:rlstyles/main.dart';

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
  // 标题
  final String title;
  const VanPopupOption({
    this.position = 'left',
    this.child,
    this.title,
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

  static OverlayEntry show({BuildContext context,VanPopupOption option}) {
    return VanOverlay.show(context:context,child: VanPopup(option: option));
  }

  static remove() {
    VanOverlay.remove();
  }

}
 
class _VanPopupState extends State<VanPopup> with TickerProviderStateMixin {

  bool isOpen = false;

  @override
  initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 10))
    .then((value) => 
      setState(() {
        isOpen = true;      
      })
    );
  }

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
        CssRule.right:0.0,
        CssRule.top:0,
        CssRule.bottom:0,
        CssRule.width:30,
        CssRule.alignItems:'center',
        CssRule.justifyContent:'center',
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
        TextView(widget.option.title ?? '标题')
      ]
    );
  }

  getPopStyle() {
    final Map<String,dynamic> styles = getStyle()['pop-${widget.option.position}'];
    styles.remove('top');
    styles.remove('left');
    styles.remove('right');
    styles.remove('bottom');
    styles.remove('position');
    return styles;
  }

  renderPop() {
    return View(
      styles:getPopStyle(),
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
      setState(() {
        isOpen = !isOpen;       
      });
    }
  }
  
  getPositionStyle() {
    final Map<String,dynamic> styles = getStyle()['pop-${widget.option.position}'];
    final double openHeight = isOpen ? 0.0 : -500.0;
    return {
      'left':widget.option.position == 'left' ? openHeight : styles['left'],
      'top':widget.option.position == 'top' ? openHeight :  styles['top'],
      'right':widget.option.position == 'right' ? openHeight :  styles['right'],
      'bottom':widget.option.position == 'bottom' ? openHeight :  styles['bottom']
    };
  }

  onAnimateEnd() {
    if (!isOpen) {
      VanOverlay.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    return View(
      styles: getStyle()['main'],
      onClick: onCancel,
      children: [
        AnimatedPositioned(
          left: getSize(size:getPositionStyle()['left'],defValue: null), 
          right: getSize(size:getPositionStyle()['right'],defValue: null), 
          bottom: getSize(size:getPositionStyle()['bottom'],defValue: null), 
          top: getSize(size:getPositionStyle()['top'],defValue: null), 
          duration: Duration(milliseconds: 500),
          child: renderPop(),
          onEnd: onAnimateEnd,
        )
      ]
    );
  }
}