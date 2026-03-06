import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';
import '../theming/styles.dart';

// generic text form field for all any text form field
class GenericTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusBorder;
  final InputBorder? enableBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;

  const GenericTextFormField({
    super.key,
    this.contentPadding,
    this.focusBorder,
    this.enableBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        enabledBorder:
            enableBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsManager.lighterGray,
                width: 1.1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
        focusedBorder:
            focusBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(color: ColorsManager.red, width: 1.1),
              borderRadius: BorderRadius.circular(20),
            ),
        hintStyle: hintStyle ?? TextStyles.font16LightGrayRegular,
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: backgroundColor ?? ColorsManager.lighterGray,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: inputTextStyle,
    );
  }
}
