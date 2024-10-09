import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Widget? prefix;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextInputType? type;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.prefix,
    this.validator,
    this.isPassword = false,
    this.type,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool toggle = true;

  void togglePassword() {
    toggle = !toggle;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.type,
      obscureText: widget.isPassword ? toggle : false,
      validator: widget.validator,
      controller: widget.controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
          labelText: widget.label,
          prefixIcon: widget.prefix,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: togglePassword,
                  icon: Icon(
                    toggle ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey.shade400,
                  ))
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade200),
    );
  }
}
