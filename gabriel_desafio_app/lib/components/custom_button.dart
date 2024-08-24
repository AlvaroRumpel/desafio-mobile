import 'package:flutter/material.dart';

import '../core/extensions/extensions.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double? width;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.width,
  })  : _type = _CustomButtonType.filled,
        borderColor = null;

  final Color? borderColor;

  const CustomButton.outlined({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderColor,
    this.width,
  }) : _type = _CustomButtonType.outlined;

  const CustomButton.cancel({
    super.key,
    required this.onPressed,
    required this.child,
    this.width,
  })  : _type = _CustomButtonType.cancel,
        borderColor = Colors.red;

  final _CustomButtonType _type;

  ButtonStyleButton get _button => switch (_type) {
        _CustomButtonType.filled => ElevatedButton(
            onPressed: onPressed,
            child: child,
          ),
        _CustomButtonType.outlined => OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: borderColor != null
                  ? BorderSide(
                      color: borderColor!,
                    )
                  : null,
            ),
            onPressed: onPressed,
            child: child,
          ),
        _CustomButtonType.cancel => OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: borderColor!),
              textStyle: TextStyle(
                color: borderColor,
              ),
            ),
            onPressed: onPressed,
            child: child,
          ),
      };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.width,
      child: _button,
    );
  }
}

enum _CustomButtonType {
  filled,
  outlined,
  cancel,
}
