import 'package:flutter/material.dart';

class VanOverlay {

  static OverlayState overlayState;
  static List<OverlayEntry> _overlayList = [];

  static renderSafe(Widget child,bool isShowTop) {
    return SafeArea( child: child,top: isShowTop);
  }

  static OverlayEntry show({BuildContext context,Widget child,bool isShowTop= true}) {
    overlayState = Overlay.of(context);
    _overlayList.add(OverlayEntry(opaque:false,builder: (BuildContext context )=> renderSafe(child,isShowTop)));
    overlayState.insert(_overlayList.last);
    return _overlayList.last;
  }

  static remove() {
    _overlayList.last.remove();
    _overlayList.removeLast();
  }
}
