import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/helperFunctions.dart';
import '../../core/values/imagePaths.dart';

class DrawerItem extends StatelessWidget {
  String text;
  String iconPath;
  Function onTap;
  bool isPointerShown;
  DrawerItem(
      {super.key,
      required this.text,
      required this.iconPath,
        required this.isPointerShown,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isPointerShown?SvgPicture.asset(ImagePaths.arrow,height: 20.spMin,width: 20.spMin,):Container(),
          isPointerShown?SizedBox(
            width: getMediaQueryWidth(context: context, value: 8),
          ):Container(),
          SvgPicture.asset(iconPath,height: 20.spMin,width: 20.spMin,),
          SizedBox(
            width: getMediaQueryWidth(context: context, value: 8),
          ),
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 24.spMin
          ))
        ],
      ),
    );
  }
}
