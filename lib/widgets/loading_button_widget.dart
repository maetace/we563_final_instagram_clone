import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String label;
  final ButtonType type;

  const LoadingButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.label,
    this.type = ButtonType.elevated,
  });

  @override
  Widget build(BuildContext context) {
    final Widget loader = switch (type) {
      ButtonType.elevated => const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
      ButtonType.outlined || ButtonType.text => const CircularProgressIndicator(strokeWidth: 2),
    };

    final Widget child = isLoading ? SizedBox(height: 20, width: 20, child: loader) : Text(label);

    final ButtonStyle style = ButtonStyle(minimumSize: WidgetStateProperty.all(const Size(double.infinity, 48)));

    return switch (type) {
      ButtonType.elevated => ElevatedButton(onPressed: onPressed, style: style, child: child),
      ButtonType.outlined => OutlinedButton(onPressed: onPressed, style: style, child: child),
      ButtonType.text => TextButton(onPressed: onPressed, style: style, child: child),
    };
  }
}

enum ButtonType { elevated, outlined, text }
