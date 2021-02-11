import 'package:flutter/material.dart';
import 'package:flutter_vant/component/icon.dart';
import 'package:rlstyles/Component/CssRule.dart';
import 'package:rlstyles/Component/TextView.dart';
import 'package:rlstyles/Component/View.dart';
import 'package:rlstyles/main.dart';

class VanCellArrowDirection {
  static const left = 'left';
  static const right = 'right';
  static const up = 'up';
  static const bottom = 'bottom';
}

class VanCellSlot {
  static const title = 'title';
  static const value = 'value';
  static const label = 'label';
}

class VanCell extends StatefulWidget {

  // 左侧标题
  final String title;
  // 右侧内容
  final String value;
  // 标签下面描述信息
  final String label;
  // 左边图标
  final dynamic icon;
  // 是否显示内边框
  final bool border;
  // 是否显示右侧箭头
  final bool isLink;
  // 是否显示星号必填项
  final bool required;
  // 是否使内容居中
  final bool center;
  // 箭头方向
  final VanCellArrowDirection arrowDirection;
  // 左侧标题样式
  final Map<String,dynamic> titleStyle;
  // 右侧内容样式
  final Map<String,dynamic> valueStyle;
  // 描述信息样式
  final Map<String,dynamic> labelStyle;
  // slot插槽
  final Map slot;
  @override
  const VanCell({
    this.title, 
    this.value, 
    this.label, 
    this.icon, 
    this.border = true, 
    this.isLink, 
    this.required, 
    this.center, 
    this.arrowDirection, 
    this.titleStyle, 
    this.valueStyle, 
    this.labelStyle = const {},
    this.slot = const {},
  });
  _VanCellState createState() => _VanCellState();
}

class _VanCellState extends State<VanCell> {

  getStyles() {
    return {
      'main':{
        CssRule.minHeight:24,
        CssRule.width:double.infinity,
        CssRule.flexDirection:'row',
        CssRule.justifyContent:'space-between',
        CssRule.alignItems:widget.center == true ? 'center' : 'flex-start',
        CssRule.backgroundColor:'white',
        CssRule.paddingLeft:10,
        CssRule.paddingRight:10,
        CssRule.paddingBottom:5,
        CssRule.paddingTop:5,
        CssRule.borderBottomColor:'##ebedf0',
        CssRule.borderBottomWidth:widget.border == true ? 0.5 : 0.0,
        CssRule.borderBottomStyle:'solid'
      },
      'left':{
        CssRule.fontSize:14,
        CssRule.color:'#323233',
      },
      'title':{
        CssRule.flexDirection:'row',
        CssRule.alignItems:'center',
        ...widget.titleStyle
      },
      'label':{
        CssRule.fontSize:12,
        CssRule.color:'#969799',
        ...widget.labelStyle
      },
      'right':{
        CssRule.fontSize:12,
        CssRule.color:'#323233',
        CssRule.flexDirection:'row',
        CssRule.alignItems:'center',
        ...widget.valueStyle
      }
    };
  }

  renderLeftTitle() {
    if (widget.title == null || widget.title == '') return Container();
    if (widget.slot['title'] != null ) return widget.slot['title'];
    return View(
      styles: getStyles()['title'],
      children: [
        VanIcon(name: widget.icon,size: 15),
        TextView(widget.title)
      ]
    );
  }

  renderLeftLable() {
    if (widget.label == null || widget.label == '') return Container();
    return widget.slot['label'] ?? TextView(widget.label,styles: getStyles()['label']) ;
  }

  renderLeft() {
    return View(
      styles: getStyles()['left'],
      children: [
        renderLeftTitle(),
        renderLeftLable()
      ]
    );
  }

  renderRight() {
    return View(
      styles: getStyles()['right'],
      children: [
        widget.slot['value'] ?? TextView('右侧',styles: getStyles()['right']),
        widget.isLink == true ? Icon(Icons.navigate_next,size: getSize(size: 15)) : Container()
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return View(
      styles: getStyles()['main'],
      children: [
        renderLeft(),
        renderRight()
      ]
    );
  }
}