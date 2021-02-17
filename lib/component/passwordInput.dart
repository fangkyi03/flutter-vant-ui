import 'package:flutter/material.dart';
import 'package:rlstyles/Component/CssRule.dart';
import 'package:rlstyles/Component/TextView.dart';
import 'package:rlstyles/Component/View.dart';

class VanPasswordInput extends StatefulWidget {

  final String value;
  final int length;
  final String info;
  final String errorInfo;
  final int gutter;
  final bool mask;
  final bool focused;
  VanPasswordInput({
    this.length = 6,
    this.gutter = 0,
    
    this.value = '',
    this.info = '',
    this.errorInfo = '',
    this.mask = true,
    this.focused = false
  });
  @override
  _VanPasswordInputState createState() => _VanPasswordInputState();
}

class _VanPasswordInputState extends State<VanPasswordInput> {

  getStyles() {
    return {
      'main':{

      },
      'pass':{
        CssRule.flexWrap:'wrap',
        CssRule.flexDirection:'row',
        CssRule.flexWrapSpacing:widget.gutter
      },
      'pass-item':{
        CssRule.width:54,
        CssRule.height:50,
        CssRule.justifyContent:'center',
        CssRule.alignItems:'center',
        CssRule.borderRightWidth:0.5,
        CssRule.borderRightColor:'#ebedf0',
        CssRule.borderRightStyle:'solid',
        CssRule.backgroundColor:'white',
        CssRule.fontSize:20
      },
      'mask':{
        CssRule.width:10,
        CssRule.height:10,
        CssRule.borderRadius:5,
        CssRule.backgroundColor:'#000000'
      }
    };
  }

  Widget renderPassItem(item) {
    return View(
      styles: getStyles()['pass-item'],
      children: [
        widget.mask ? View(styles: getStyles()['mask']) : TextView(item)
      ],
    );
  }

  List<String> getRangeArr() {
    final List<String> splitArr = widget.value.split('');
    if (splitArr.length > widget.length) {
      return splitArr.getRange(0,widget.length).toList();
    }else {
      return splitArr;
    }
  }

  renderPass() {
    return View(
      styles: getStyles()['pass'],
      children: getRangeArr().map((e)=>this.renderPassItem(e)).toList(),
    );
  }

  renderInfo() {
    if (widget.info == null || widget.info == '') return Container();
    return View(
      styles: getStyles()['info'],
      children: [
        TextView(widget.info)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return View(
      styles: getStyles()['main'],
      children: [
        renderPass(),
        renderInfo()
      ]
    );
  }
}