import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/font_manager.dart';
import '../resources/theme_color.dart';
import '../resources/values_manager.dart';

class BuildTextField extends StatefulWidget {
  const BuildTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.label,
    this.hint,
    this.isObscured = false,
    this.iconData,
    this.textInputType = TextInputType.text,
    this.backgroundColor,
    this.hintTextStyle,
    this.labelTextStyle,
    this.cursorColor,
    this.readOnly = false,
    this.validation,
    this.onTap,
    this.maxLines,
    this.prefixIcon,
    this.borderBackgroundColor,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool isObscured;
  final String? label;
  final String? hint;
  final TextInputType textInputType;
  final IconData? iconData;
  final Color? backgroundColor;
  final Color? borderBackgroundColor;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final Color? cursorColor;
  final bool readOnly;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validation;
  final void Function()? onTap;

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  late bool hidden = widget.isObscured;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(top: AppPadding.p2),
            child: Text(
              widget.label!,
              style: widget.labelTextStyle ??
                  TextStyle(
                    color: AppColors.primaryDarkColor,
                    fontSize: FontSize.s14.sp,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        Container(
          margin: const EdgeInsets.only(top: AppMargin.m5),
          decoration: BoxDecoration(
            color: widget.backgroundColor ??
                AppColors.primaryDarkColor.withOpacity(.07),
            borderRadius: BorderRadius.circular(AppSize.s8),
            border: Border.all(
              color:
              widget.borderBackgroundColor ?? AppColors.primaryDarkColor,
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: TextFormField(
            maxLines: widget.maxLines ?? 1,
            controller: widget.controller,
            focusNode: widget.focusNode,
            readOnly: widget.readOnly,
            style: TextStyle(
              color: AppColors.primaryDarkColor,
              fontSize: FontSize.s16.sp,
            ),
            obscureText: hidden,
            keyboardType: widget.textInputType,
            obscuringCharacter: '*',
            cursorColor: widget.cursorColor ?? AppColors.primaryDarkColor,
            onTap: widget.onTap,
            onEditingComplete: () {
              widget.focusNode?.unfocus();
              if (widget.nextFocus != null) {
                FocusScope.of(context).requestFocus(widget.nextFocus!);
              }
            },
            textInputAction: widget.nextFocus == null
                ? TextInputAction.done
                : TextInputAction.next,
            validator: (value) {
              if (widget.validation == null) {
                setState(() => errorText = null);
              } else {
                setState(() => errorText = widget.validation!(value));
              }
              return errorText;
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(AppPadding.p12),
              hintText: widget.hint,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isObscured
                  ? IconButton(
                onPressed: () => setState(() => hidden = !hidden),
                iconSize: AppSize.s24,
                splashRadius: AppSize.s1,
                color: AppColors.primaryDarkColor,
                icon: Icon(
                    hidden ? Icons.visibility_off : Icons.remove_red_eye_rounded),
              )
                  : widget.suffixIcon,
              hintStyle: widget.hintTextStyle ??
                  TextStyle(
                    color: AppColors.primaryDarkColor.withOpacity(0.5),
                    fontSize: 16.sp,
                  ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorStyle: const TextStyle(
                fontSize: 0, // نمنع تكرار الخطأ مرتين
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(
              top: AppPadding.p8,
              left: AppPadding.p8,
            ),
            child: Text(
              errorText!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.sp,
              ),
            ),
          ),
      ],
    );
  }
}
