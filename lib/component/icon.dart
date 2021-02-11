import 'package:flutter/material.dart';
import 'package:flutter_vant/component/badge.dart';
import 'package:rlstyles/Component/HexColor.dart';
import 'package:rlstyles/main.dart';

// ignore: must_be_immutable
class VanIcon extends StatefulWidget {
  // 图片名称或者链接
  final dynamic name;
  // dot
  final bool dot;
  // 右上角徽标内容
  final dynamic badge;
  // 图标颜色
  final dynamic color;
  // 图标尺寸
  final dynamic size;
  // className
  final Map<String,dynamic> className;
  const VanIcon(
      {this.name,
      this.dot,
      this.badge,
      this.className = const {},
      this.size = 20,
      this.color = '#000000'});
  @override
  _VanIconState createState() => _VanIconState();
}

class _VanIconState extends State<VanIcon> {
  renderIcon() {
    if (widget.name.runtimeType.toString() == 'String' &&
        widget.name.indexOf('http') != -1) {
      return Image(
        width: getSize(size: widget.size),
        height: getSize(size: widget.size),
        image: NetworkImage(widget.name),
        fit: BoxFit.cover,
      );
    } else {
      return Icon(widget.name,
          color: HexColor(widget.color), size: getSize(size: widget.size));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.name == null ) return Container();
    return VanBadge(
      dot: widget.dot,
      badge: widget.badge,
      size: widget.size,
      className: widget.className,
      child: renderIcon(),
    );
  }
}
