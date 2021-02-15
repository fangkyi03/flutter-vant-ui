import 'package:flutter/material.dart';
import 'package:rlstyles/Component/CssRule.dart';
import 'package:rlstyles/Component/StylesMap.dart';
import 'package:rlstyles/Component/TextView.dart';
import 'package:rlstyles/Component/View.dart';
import 'package:rlstyles/main.dart';

class VanBadge extends StatefulWidget {
  final Widget child;
  // dot
  final bool dot;
  // 右上角徽标内容
  final dynamic badge;
  // 图标尺寸
  final dynamic size;
  // 主样式
  final Map<String,dynamic> className;
  // dot样式
  final Map dotClass;
  // badge样式
  final Map badgeClass;
  // 子元素名称
  final Widget content;
  const VanBadge(
    {
      this.child,
      this.dot = false,
      this.badge,
      this.size,
      this.content,
      this.badgeClass = const {},
      this.dotClass = const {},
      this.className = const {}
    });
  @override
  _VanBadgeState createState() => _VanBadgeState();
}

class _VanBadgeState extends State<VanBadge> {
  getStyle() {
    return {
      'main': {
        CssRule.width: widget.size != null
        ? widget.size + (widget.badge != null ? widget.badge.toString().length * 7 : 0.0)
        : null,
        CssRule.height: widget.size != null
        ? getSize(size:widget.size) + (widget.badge != null ? 10.0 : 3.0) + (widget.content != null ? 20.0 : 0.0)
        : null,
        CssRule.paddingRight: 3.0,
        CssRule.paddingTop: 3.0,
        CssRule.justifyContent: 'flex-end',
        ...widget.className
      },
      'dot': {
        CssRule.position: 'abs',
        CssRule.right: 1.0,
        CssRule.top: 0.0,
        CssRule.width: 8.0,
        CssRule.height: 8.0,
        CssRule.borderRadius: 4.0,
        CssRule.backgroundColor: '#ee0a24',
        CssRule.fontSize: 10.0,
        CssRule.fontWeight: 0,
        CssRule.color: 'white',
        CssRule.justifyContent: 'center',
        CssRule.alignItems: 'center',
        ...widget.dotClass
      },
      'badge': {
        CssRule.position: 'abs',
        CssRule.right: 1.0,
        CssRule.top: 0.0,
        CssRule.width: widget.badge.toString().length * 10,
        CssRule.height: 16,
        CssRule.borderRadius: 999.0,
        CssRule.backgroundColor: '#ee0a24',
        CssRule.fontSize: 10.0,
        CssRule.color: 'white',
        CssRule.justifyContent: 'center',
        CssRule.alignItems: 'center',
        ...widget.badgeClass
      }
    };
  }

  getBadge() {
    if (widget.badge.runtimeType.toString() == 'int') {
      if (widget.badge > 99) {
        return '99+';
      } else {
        return widget.badge.toString();
      }
    }
    return widget.badge;
  }

  renderBadge() {
    if (widget.dot == null && widget.badge == null) {
      return Container();
    }
    final cls = StylesMap.getClass({'dot': widget.dot, 'badge': widget.badge != null}, getStyle());
    return View(
      styles: cls,
      children: [widget.badge != null ? TextView(getBadge()) : Container()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return View(
      styles: getStyle()['main'],
      children: [widget.child, renderBadge()],
    );
  }
}
