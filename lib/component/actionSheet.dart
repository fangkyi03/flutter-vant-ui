import 'package:flutter/material.dart';
import 'package:flutter_vant/component/popup.dart';
import 'package:rlstyles/Component/CssRule.dart';
import 'package:rlstyles/Component/HexColor.dart';
import 'package:rlstyles/Component/TextView.dart';
import 'package:rlstyles/Component/View.dart';
import 'package:rlstyles/main.dart';

class VanActionSheetAction {
  // 标题
  final String name;
  // 二级标题
  final String subname;
  // 文字颜色
  final dynamic color;
  // 额外样式
  final Map<String,dynamic> className;
  // 是否加载状态
  final bool loading;
  // 是否禁用状态
  final bool disabled;
  VanActionSheetAction({
    this.name,
    this.subname,
    this.color,
    this.className = const {},
    this.loading,
    this.disabled
  });
}

class VanActionSheetOption {
  // 面板选项列表	
  final List<VanActionSheetAction> actions;
  // 顶部标题	
  final String title;
  // 取消按钮文字	
  final String cancelText;
  // 选项上方的描述信息	
  final String description;
  // 是否显示关闭图标	
  final bool closeable;
  // 关闭图标名称或图片链接	
  final dynamic closeIcon;
  // 是否显示圆角
  final bool round;
  // 是否显示遮罩层	
  final bool overlay;

  VanActionSheetOption({
    this.title,
    this.actions = const [],
    this.closeIcon, 
    this.cancelText, 
    this.description, 
    this.round = false,
    this.overlay = false,
    this.closeable = true, 
  });
}

class VanActionSheet extends StatefulWidget {

  final VanActionSheetOption option;

  VanActionSheet({this.option});
  @override
  _VanActionSheetState createState() => _VanActionSheetState();

  static show({BuildContext context,VanActionSheetOption option}) {
    VanPopup.show(
      context: context,
      option:VanPopupOption(
        round: option.round,
        overlay:option.overlay,
        isShowHeader: false,
        position: 'bottom',
        child: VanActionSheet(option: option)
      )
    );
  }

  static remove() {
    VanPopup.remove();
  }

}

class _VanActionSheetState extends State<VanActionSheet> {

  getStyles() {
    return {
      'description':{
        CssRule.height:60,
        CssRule.width:double.infinity,
        CssRule.alignItems:'center',
        CssRule.justifyContent:'center',
        CssRule.fontSize:14,
        CssRule.color:'rgb(150, 151, 153)',
        CssRule.borderBottomColor:'#ebedf0',
        CssRule.borderBottomWidth:0.5,
        CssRule.borderBottomStyle:'solid',
      },
      'list-item':{
        CssRule.alignItems:'center',
        CssRule.justifyContent:'center',
        CssRule.fontSize:16,
        CssRule.color:'rgb(50, 50, 51)',
        CssRule.width:double.infinity,
        CssRule.height:50
      },
      'list-item-desc':{
        CssRule.fontSize:12,
        CssRule.color:'rgb(150, 151, 153)',
      },
      'cancelButton':{
        CssRule.alignItems:'center',
        CssRule.justifyContent:'center',
        CssRule.width:double.infinity,
        CssRule.height:50
      }
    };
  }

  renderLoading() {
    return View(
      styles: getStyles()['list-item'],
      children: [
        SizedBox(
          width: getSize(size: 20),
          height: getSize(size: 20),
          child: CircularProgressIndicator(
            strokeWidth: 1,
            valueColor: AlwaysStoppedAnimation(HexColor('#c8c9cc')),
          )
        )
      ],
    );
  }

  Widget renderListItem(VanActionSheetAction item) {
    if (item.loading == true) return renderLoading();
    return View(
      styles: {...getStyles()['list-item'],CssRule.color:item.color},
      children: [
        TextView('child'),
        item.subname != null ? TextView(item.subname,styles: getStyles()['list-item-desc']) : Container()
      ],
    );
  }

  List<Widget> renderList() {
    return widget.option.actions.map((e){
      return renderListItem(e);
    }).toList();
  }

  renderDesc() {
    if (widget.option.description != null ) {
      return View(
        styles: getStyles()['description'],
        children: [
          TextView(widget.option.description)
        ],
      );
    }else {
      return Container();
    }
  }

  renderCancelButton() {
    if (widget.option.cancelText != null) {
      return View(
        children: [
          View(styles: {CssRule.backgroundColor:'#f7f8fa',CssRule.height:8,CssRule.width:double.infinity}),
          View(
            styles: getStyles()['cancelButton'],
            children: [
              TextView(widget.option.cancelText ?? '取消')
            ]
          )
        ]
      );
    }else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return View(
      children: [
        renderDesc(),
        ...renderList(),
        renderCancelButton()
      ]
    );
  }
}