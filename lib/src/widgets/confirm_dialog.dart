import 'package:flutter/material.dart'
    show
        AlertDialog,
        BuildContext,
        Navigator,
        StatelessWidget,
        Text,
        Widget,
        showDialog;

import '../close_dialog_config.dart' show CloseDialogConfig;
import 'text_button.dart' show TextButton;

class ConfirmDialog extends StatelessWidget {
  final CloseDialogConfig config;
  final Future<void> Function()? onClose;

  const ConfirmDialog({super.key, required this.config, this.onClose});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(config.title),
      content: Text(config.content),
      actions: [
        TextButton(
          text: config.confirmText,
          onPressed: () async {
            if (onClose != null) await onClose!();
            if (!context.mounted) return;

            Navigator.of(context).pop(true);
          },
        ),
        TextButton(
          text: config.cancelText,
          onPressed: () async => Navigator.of(context).pop(false),
          isOutlinedButton: true,
        ),
      ],
    );
  }

  static Future<bool> show(
    BuildContext context, {
    required CloseDialogConfig config,
    Future<void> Function()? onClose,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmDialog(config: config, onClose: onClose),
    );

    return confirmed ?? false;
  }
}
