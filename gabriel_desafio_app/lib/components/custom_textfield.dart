import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/utils/validation.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.prefixIcon,
    this.validators,
    this.inputFormatters,
    this.obscureText = false,
    this.onPressViewPass,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData? prefixIcon;
  final List<Validation>? validators;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final VoidCallback? onPressViewPass;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: onPressViewPass == null
            ? null
            : obscureText
                ? IconButton(
                    icon: const Icon(Icons.visibility_outlined),
                    onPressed: onPressViewPass,
                  )
                : IconButton(
                    icon: const Icon(Icons.visibility_off_outlined),
                    onPressed: onPressViewPass,
                  ),
      ),
      obscureText: obscureText,
      validator: validators?.validate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters,
    );
  }
}
