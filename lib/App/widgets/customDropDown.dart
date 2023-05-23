// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/utils/helperFunctions.dart';
import '../../core/values/colors.dart';

class CustomDropdownButton extends StatelessWidget {
  TextStyle textStyle;
  List<String> data;
  String? iconPath;
  String? prefixIconPath;
  double width;
  double height;
  String? hint;
  Color? backGroundColor;
  IconData? prefixIconData;/// used in case there is no svg icon provided
  Function(String)? onChange;
  CustomDropdownButton(
      {Key? key,
      this.backGroundColor = textFormFieldColor,
      required this.data,
      required this.textStyle,
      required this.onChange,
      this.prefixIconPath,
        this.prefixIconData,
      this.width = 148,
      this.hint,
      this.height = 48,
      this.iconPath})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          hint: hint != null
              ? Text(
                  hint!,
                  style: TextStyle(fontSize: 16.spMin),
                )
              : Container(),
          isExpanded: true,
          validator: (value) {
            return validateDropDown(value);
          },
          icon: Container(),
          menuMaxHeight: getMediaQueryHeight(context: context, value: 250),
          decoration: InputDecoration(
            fillColor: backGroundColor,
            filled: true,
            contentPadding: EdgeInsets.only(top: 19.h,bottom: 19.h),
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
            suffixIcon: IconButton(
              icon: SvgPicture.asset(
                "images/arrowright2.svg",
                height: 20.spMin,
                width: 20.spMin,
              ),
              onPressed: null,
            ),
            prefixIcon: IconButton(
              icon:prefixIconPath!=null? SvgPicture.asset(
                prefixIconPath!,
                height: 24.spMin,
                width: 24.spMin,
              ):Icon(prefixIconData,size: 24.spMin,),
              onPressed: null,
            ),
          ),
          items: data.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Center(
                child: FittedBox(
                  child: Row(
                    children: <Widget>[
                      Text(
                        value,
                        style: TextStyle(fontSize: 16.spMin),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: (value,) {
            onChange!(value!);
          },
        ),
      ),
    );
  }
}
