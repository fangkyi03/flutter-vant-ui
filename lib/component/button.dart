import 'package:flutter/material.dart';
import 'package:rlstyles/Component/HexColor.dart';
import 'package:rlstyles/main.dart';

class VanButtonType {
  static String normal = 'default';
  static String primary = 'primary';
  static String success = 'success';
  static String warning = 'warning';
  static String danger = 'danger';
}

class VanButtonSize {
  static String large = 'large';
  static String small = 'small';
  static String mini = 'mini';
}

class VanButton extends StatefulWidget {
  // 按钮类型
  final String type;
  // 顶级元素class样式
  final Map className;
  // 尺寸
  final String size;
  // 是否圆角显示
  final bool round;
  // 是否直角显示
  final bool square;
  // 是否撑满
  final bool block;
  // 是否简洁模式
  final bool plain;
  // loading
  final bool loading;
  // loading提示
  final String loadingText;
  // loading大小
  final double loadingSize;
  // icon位置
  final String iconPosition;
  // 是否禁用
  final bool disabled;
  // 头发丝0.5
  final bool hairline;
  // 内容
  final String text;
  // icon颜色
  final dynamic iconColor;
  // icon大小
  final dynamic iconSize;
  // 图标
  final dynamic icon;
  // 点击事件
  final GestureTapCallback onClick;
  @override
  _VanButtonState createState() => _VanButtonState();

  const VanButton(
      {this.type = 'default',
      this.className,
      this.icon,
      this.loadingText,
      this.text,
      this.onClick,
      this.iconColor,
      this.disabled = false,
      this.hairline = false,
      this.iconPosition = 'left',
      this.loadingSize = 15,
      this.size = 'small',
      this.iconSize = 20.0,
      this.loading = false,
      this.round = false,
      this.square = false,
      this.block = false,
      this.plain = false});
}

class _VanButtonState extends State<VanButton> {
  getStyles() {
    return {
      'button': {
        CssRule.borderWidth: widget.hairline == true ? 0.5 : 1.0,
        CssRule.borderStyle: 'solid',
        CssRule.alignItems: 'center',
        CssRule.justifyContent: 'center',
        CssRule.flexDirection: 'row',
        CssRule.height: 30,
        // CssRule.padding: 15.0,
        CssRule.paddingLeft: 5.0,
        CssRule.paddingRight: 5.0,
        CssRule.fontSize: 14.0,
        CssRule.borderRadius: widget.round ? 5.0 : 0.0,
        CssRule.textAlign: 'center',
        CssRule.opacity: widget.disabled == true ? 0.5 : 1.0
      },
      'btn-primary': {
        CssRule.backgroundColor: widget.plain ? 'white' : '#1989fa',
        CssRule.borderColor: '#1989fa',
        CssRule.color: widget.plain ? '#1989fa' : 'white',
        ...widget.className ?? {}
      },
      'btn-success': {
        CssRule.backgroundColor: widget.plain ? 'white' : '#07c160',
        CssRule.borderColor: '#07c160',
        CssRule.color: widget.plain ? '#07c160' : 'white',
        ...widget.className ?? {}
      },
      'btn-danger': {
        CssRule.backgroundColor: widget.plain ? 'white' : '#ee0a24',
        CssRule.borderColor: '#ee0a24',
        CssRule.color: widget.plain ? '#ee0a24' : 'white',
        ...widget.className ?? {}
      },
      'btn-warning': {
        CssRule.backgroundColor: widget.plain ? 'white' : '#ff976a',
        CssRule.borderColor: '#ff976a',
        CssRule.color: widget.plain ? '#ff976a' : 'white',
        ...widget.className ?? {}
      },
      'btn-default': {
        CssRule.backgroundColor: 'white',
        CssRule.borderColor: '#ebedf0',
        CssRule.color: 'black',
        ...widget.className ?? {}
      },
      'btn-size-mini': {
        CssRule.minWidth: 56.0,
        CssRule.minHeight: 22.0,
        // CssRule.maxHeight: 30.0
      },
      'btn-size-large': {
        CssRule.minWidth: 86.0,
        CssRule.minHeight: 42.0,
        // CssRule.maxHeight: 50.0
      },
      'btn-size-small': {
        CssRule.minWidth: 64.0,
        CssRule.minHeight: 32.0,
        // CssRule.maxHeight: 40.0
      },
      'btn-block': {CssRule.width: double.infinity},
    };
  }

  getIconColor() {
    Map obj = {
      VanButtonType.normal: Colors.black,
      VanButtonType.warning: '#ff976a',
      VanButtonType.danger: '#ee0a24',
      VanButtonType.primary: '#1989fa',
      VanButtonType.success: '#07c160'
    };
    if (widget.iconColor != null) return HexColor(widget.iconColor);
    if (widget.plain == true) {
      return HexColor(obj[widget.type]);
    } else {
      if (widget.type == VanButtonType.normal) {
        return Colors.black;
      } else {
        return Colors.white;
      }
    }
  }

  renderIcon(String position) {
    Widget element;
    if (widget.iconPosition != position || widget.icon == null)
      return Container();
    if (widget.icon.runtimeType.toString() == 'String' &&
        widget.icon.indexOf('http') != -1) {
      element = Image(
        width: getSize(size: widget.iconSize),
        height: getSize(size: widget.iconSize),
        image: NetworkImage(widget.icon),
        fit: BoxFit.cover,
      );
    } else {
      element = Icon(widget.icon,
          color: getIconColor(), size: getSize(size: widget.iconSize));
    }
    return View(
      styles: {
        CssRule.marginLeft: 5.0,
        CssRule.marginRight: 5.0,
        CssRule.width: widget.iconSize,
        CssRule.height: widget.iconSize
      },
      children: [element],
    );
  }

  renderLoading() {
    if (!widget.loading) return Container();
    return View(
      styles: {
        CssRule.marginRight: 5.0,
        // CssRule.marginBottom: 5.0,
        CssRule.marginTop: 2.0,
        CssRule.alignItems: 'center',
        CssRule.justifyContent: 'center',
      },
      children: [
        SizedBox(
            width: widget.loadingSize,
            height: widget.loadingSize,
            child: CircularProgressIndicator(
                strokeWidth: 1,
                valueColor: AlwaysStoppedAnimation(Colors.white)))
      ],
    );
  }

  renderContent() {
    return TextView(
      widget.loading ? widget.loadingText ?? widget.text : widget.text,
      styles: {CssRule.fontWeight: 0, CssRule.fontSize: 15.0},
    );
  }

  getMainClass() {
    Map css = {
      'button': true,
      'btn-block': widget.block,
      'btn-${widget.type}': true,
      'btn-size-${widget.size}': widget.size != null,
    };
    return StylesMap.getClass(css, getStyles());
  }

  @override
  Widget build(BuildContext context) {
    return View(
        styles: getMainClass(),
        onClick: widget.disabled == false ? widget.onClick : () => {},
        children: [
          renderIcon('left'),
          renderLoading(),
          renderContent(),
          renderIcon('right')
        ]);
  }
}
