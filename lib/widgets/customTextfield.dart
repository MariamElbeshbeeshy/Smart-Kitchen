import 'package:flutter/material.dart';

class CustomTextFormFeild extends StatelessWidget {
  const CustomTextFormFeild({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isPassword,
    required this.isHidden,
    required this.onToggleVisibility,
    this.prefixIcon,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool isHidden;
  final VoidCallback onToggleVisibility;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? isHidden : false,
      decoration: InputDecoration(
        label: Text(hintText,style: TextStyle(color: Color(0xFF0A5710)),),
focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF4CAF50)),
          ),
        prefixIcon: prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: prefixIcon,
              ),

        suffixIcon: isPassword
            ? IconButton(
                onPressed: onToggleVisibility,
                icon: Icon(
                  isHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,color: const Color(0xFF47814C),
                ),
              )
            : null,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}