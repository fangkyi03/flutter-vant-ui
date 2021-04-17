import 'package:flutter/material.dart';
import 'package:flutter_vant/component/cell.dart';
import 'package:rlstyles/Component/View.dart';

class VanField extends StatefulWidget {
  @override
  _VanFieldState createState() => _VanFieldState();
}

class _VanFieldState extends State<VanField> {
  Widget renderValue() {
    return Container(
      width: 200,
      child: TextField(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VanCell(slot: {VanCellSlot.value: this.renderValue()});
  }
}
