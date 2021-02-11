import 'package:flutter/material.dart';
import 'package:flutter_vant/component/cell.dart';
import 'package:flutter_vant/component/icon.dart';
import 'package:rlstyles/Component/CssRule.dart';
import 'package:rlstyles/Component/TextView.dart';
import 'package:rlstyles/Component/View.dart';

class VanCellGroup extends StatefulWidget {
  final String title;
  final dynamic icon;
  final List<VanCell> children;
  const VanCellGroup({this.title,this.children = const [],this.icon});
  @override
  _VanCellGroupState createState() => _VanCellGroupState();
}

class _VanCellGroupState extends State<VanCellGroup> {

  getStyles() {
    return {
      'main':{

      },
      'title':{
        CssRule.color:'#969799',
        CssRule.fontSize:14,
        CssRule.flexDirection:'row',
        CssRule.alignItems:'center',
        CssRule.paddingLeft:5
      }
    };
  }

  renderTitle() {
    if (widget.title == null) return Container();
    return View(
      styles: getStyles()['title'],
      children: [
        TextView(widget.title),
        VanIcon(name: widget.icon,size: 15,className: {CssRule.marginLeft:10})
      ]
    );
  }

  renderCell() {
    if (widget.children.length > 0) {
      return widget.children;
    }else {
      return [Container()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return View(
      styles: getStyles()['main'],
      children: [
        renderTitle(),
        ...renderCell()
      ],
    );
  }
}