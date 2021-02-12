import 'package:flutter/material.dart';
import 'package:rlstyles/Component/View.dart';

class VanCheckBoxGroup extends StatefulWidget {
  final List<Widget> children;

  const VanCheckBoxGroup({
    this.children = const []
  }):assert(children.length <= 0 );
  @override
  _VanCheckBoxGroupState createState() => _VanCheckBoxGroupState();
}

class _VanCheckBoxGroupState extends State<VanCheckBoxGroup> {

  getStyles() {
    return {
      'main':{

      }
    };
  }

  renderChildren(Widget child) {

  }

  @override
  Widget build(BuildContext context) {
    return View(
      styles:getStyles()['main'] ,
      children: widget.children.map((e)=> renderChildren(e)).toList()
    );
  }
}