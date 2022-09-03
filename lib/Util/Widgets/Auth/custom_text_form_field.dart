import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Icon? icon;
  final Widget? suffixIcon;
  final String? errorText;
  final FormFieldValidator<String?>? validator;
  final FormFieldSetter<String?>? onsaved;
  final Function(String)? onChanged;
  final bool isPass;
  final String? hintText;
  final TextInputType? textInputType;

  const CustomTextFormField(
      {Key? key,
      this.validator,
      this.onChanged,
      this.onsaved,
      this.errorText,
      this.suffixIcon,
      this.controller,
      this.isPass = false,
      required this.hintText,
      required this.textInputType,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
        suffixIcon: suffixIcon,
        prefixIcon: icon,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      controller: controller,
      keyboardType: textInputType,
      obscureText: isPass,
      onSaved: onsaved,
    );
  }
}
