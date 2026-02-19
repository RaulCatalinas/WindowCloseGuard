import 'package:flutter/material.dart' show BuildContext, WidgetsBinding;
import 'package:window_manager/window_manager.dart'
    show WindowListener, windowManager;

import 'close_dialog_config.dart' show CloseDialogConfig;
import 'widgets/confirm_dialog.dart' show ConfirmDialog;

class WindowCloseGuard with WindowListener {
  static final WindowCloseGuard _instance = WindowCloseGuard._internal();
  WindowCloseGuard._internal();

  static BuildContext? _context;
  static Future<void> Function()? _onClose;
  static CloseDialogConfig? _dialogConfig;
  static bool _showDialog = true;
  static bool _initialized = false;

  static void initialize({
    required BuildContext context,
    Future<void> Function()? onClose,
    CloseDialogConfig? dialogConfig,
    bool showDialog = true,
  }) {
    if (_initialized) return;
    _initialized = true;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _context = context;
      _onClose = onClose;
      _dialogConfig = dialogConfig;
      _showDialog = showDialog;

      await windowManager.ensureInitialized();
      await windowManager.setPreventClose(true);
      windowManager.addListener(_instance);
    });
  }

  @override
  void onWindowClose() async {
    final context = _context;
    if (context == null || !context.mounted) return;

    if (!_showDialog) {
      if (_onClose != null) await _onClose!();
      await _handleCloseEvent();
      return;
    }

    final confirmed = await ConfirmDialog.show(
      context,
      config: _dialogConfig ?? const CloseDialogConfig(),
      onClose: _onClose,
    );

    if (!confirmed) return;

    await _handleCloseEvent();
  }

  Future<void> _handleCloseEvent() async {
    windowManager.removeListener(_instance);
    await windowManager.setPreventClose(false);
    await windowManager.close();
  }
}
