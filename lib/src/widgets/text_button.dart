import 'package:flutter/material.dart'
    show
        BuildContext,
        ElevatedButton,
        OutlinedButton,
        StatelessWidget,
        Text,
        Widget,
        ButtonStyle,
        TextAlign;

class TextButton extends StatelessWidget {
  final String text;
  final Future<void> Function()? onPressed;
  final bool isOutlinedButton;
  final bool centerText;

  const TextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlinedButton = false,
    this.centerText = false,
  });

  @override
  Widget build(BuildContext context) {
    final commonChild = Text(
      text,
      textAlign: centerText ? TextAlign.center : null,
    );
    final commonStyle = const ButtonStyle(enableFeedback: true);

    return isOutlinedButton
        ? OutlinedButton(
            onPressed: () async {
              if (onPressed == null) return;
              await onPressed!();
            },
            style: commonStyle,
            child: commonChild,
          )
        : ElevatedButton(
            onPressed: () async {
              if (onPressed == null) return;
              await onPressed!();
            },
            style: commonStyle,
            child: commonChild,
          );
  }
}
