import 'package:flutter/material.dart';

class VanNumberKeyboardOption {

  // 控制是否显示
  final bool show ;
  // 键盘标题
  final String title;
  // 主题风格
  final String thme;
  // 输入最大长度
  final int maxLength;
  // 扩展键
  final List<String> extraKey;
  // 关闭按钮文字，空则不展示	
  final String closeButtonText;
  // 删除按钮文字，空则展示删除图标	
  final String deleteButtonText;
  // 是否将关闭按钮设置为加载中状态，仅在 theme="custom" 时有效	
  final bool closeButtonLoading;
  // 是否展示删除图标	
  final bool showDeleteKey;
  // 点击外部是否收起键盘
  final bool hideClickOutside;

  VanNumberKeyboardOption({
    this.title, 
    this.extraKey, 
    this.closeButtonText, 
    this.deleteButtonText, 
    this.closeButtonLoading, 
    this.showDeleteKey, 
    this.hideClickOutside,
    this.show = false,
    this.thme = 'default', 
    this.maxLength = 6, 
  });
}

class VanNumberKeyboard extends StatefulWidget {
  @override
  _VanNumberKeyboardState createState() => _VanNumberKeyboardState();
}

class _VanNumberKeyboardState extends State<VanNumberKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}