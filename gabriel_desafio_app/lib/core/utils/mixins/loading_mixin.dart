import 'package:flutter/material.dart';

mixin LoadingMixin {
  OverlayEntry? _overlayEntry;

  void showLoading(BuildContext context) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.black.withOpacity(0.5),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void hideLoading() {
    if (_overlayEntry == null) {
      Future.delayed(Durations.extralong4, _removeOverlayEntry);

      return;
    }

    _removeOverlayEntry();
  }

  void _removeOverlayEntry() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
