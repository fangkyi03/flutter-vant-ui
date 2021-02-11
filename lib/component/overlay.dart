import 'package:flutter/material.dart';

class VanOverlay {
  static OverlayState overlayState;
  static OverlayEntry _overlayEntry;

  static renderSafe(Widget child) {
    return SafeArea(child: child);
  }

  static show({BuildContext context,Widget child}) {
    overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(opaque:false,builder: (BuildContext context )=> renderSafe(child));
    overlayState.insert(_overlayEntry);
  }

  static remove() {
    _overlayEntry.remove();
  }
}
