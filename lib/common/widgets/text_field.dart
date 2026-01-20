import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:margintop_solutions/extensions/extensions.dart';

class TextFieldData extends StatefulWidget {
  const TextFieldData({
    super.key,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.isPassword = false,
    this.maxLines = 1,
    this.prefixIcon,
  });
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final int? maxLines;
  final IconData? prefixIcon;
  @override
  State<TextFieldData> createState() => _TextFieldDataState();
}

class _TextFieldDataState extends State<TextFieldData> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      autovalidateMode: AutovalidateMode.onUnfocus,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      autofocus: false,
      textInputAction: TextInputAction.done,
      obscureText: widget.isPassword ? _obscureText : false,
      style: context.textTheme.titleMedium,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        hintStyle: context.textTheme.titleMedium,
        suffixIcon: widget.isPassword
            ? IconButton(
                style: IconButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  padding: EdgeInsets.zero,
                  iconSize: 20,
                ),
                icon: Icon(
                  _obscureText ? Iconsax.eye_slash : Iconsax.eye,
                ),
                onPressed: () {
                  if (mounted) {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  }
                },
              )
            : null,
      ),
    );
  }
}
