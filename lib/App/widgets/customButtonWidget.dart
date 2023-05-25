import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/values/colors.dart';

///الزر هادا مستخدم بكل الشاشات
class CustomButton extends StatelessWidget {
  Function onPressed;
  String text;
  double? width;

  CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: customButtonColor),
        width: width ?? MediaQuery.of(context).size.width * 0.872,
        
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 16.spMin),
            ),
          ),
        ),
      ),
    );
  }
}
