import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/values/colors.dart';

class CustomFormField extends StatelessWidget {
  IconButton? prefixIcon;
  IconButton? suffixIcon;
  Function validator;
  Function? onFieldSubmitted;
  Color backGroundColor;
  String? hint;
  double? hintSize;
  String? initalValue;
  bool? enabled;
  int? maxLength;
  bool isPassword;
  double? leftPadding=0;
  double width;
  double? topContentPadding;
  double? bottomContentPadding;
  Color iconColor;
  TextInputType? textInputType;
  TextEditingController? controller;
  TextEditingController? passwordConfirmController;
  int? maxLines;
  int minLines;
  FocusNode? focusNode;

  CustomFormField(
      {this.prefixIcon,
      this.suffixIcon,
      this.hintSize,
      required this.validator,
      this.enabled,
      this.initalValue,
         this.leftPadding,
        this.topContentPadding,
        this.bottomContentPadding,
      this.onFieldSubmitted,
      this.maxLength,
      this.passwordConfirmController,
      this.backGroundColor = textFormFieldColor,
      required this.controller,
      this.hint,
      this.maxLines = 1,
      this.minLines = 1,
      required this.isPassword,
      required this.width,
      this.textInputType,
      this.focusNode,
      this.iconColor = iconPrimaryColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        minLines: minLines,
        maxLines: maxLines,
        initialValue: initalValue,
        enabled: enabled,
        maxLength: maxLength,
        textAlignVertical: TextAlignVertical.top,
        keyboardType: textInputType,
        style: const TextStyle(height: 1.5),
        onFieldSubmitted: (tap) {
          onFieldSubmitted!();
        },
        selectionControls: MaterialTextSelectionControls(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        focusNode: focusNode,
        validator: (value) {
          if (passwordConfirmController != null) {
            return validator(value, passwordConfirmController);
          } else {
            return validator(value);
          }
        },
        obscureText: isPassword,
        decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 16.spMin),
            contentPadding: EdgeInsets.only(
                top:topContentPadding!.h,
              bottom:bottomContentPadding!.h,
              left: leftPadding!.w
            ),
            fillColor: backGroundColor,
            filled: true,
            isDense: true,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            iconColor: iconPrimaryColor,
            errorMaxLines: 2,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: textFormFieldColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: textFormFieldColor)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: textFormFieldColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: textFormFieldColor)),
            hintText: hint),
      ),
    );
  }
}
