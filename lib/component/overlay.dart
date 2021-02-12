import 'package:flutter/material.dart';

class VanOverlay {

  static OverlayState overlayState;
  static List<OverlayEntry> _overlayList = [];

  static renderSafe(Widget child) {
    return SafeArea(child: child);
  }

  static OverlayEntry show({BuildContext context,Widget child}) {
    overlayState = Overlay.of(context);
    _overlayList.add(OverlayEntry(opaque:false,builder: (BuildContext context )=> renderSafe(child)));
    overlayState.insert(_overlayList.last);
    return _overlayList.last;
  }

  static remove() {
    _overlayList.last.remove();
    _overlayList.removeLast();
  }
}
