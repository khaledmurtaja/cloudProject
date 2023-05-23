import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/manegerHome/controller.dart';
import 'package:getx_architecture/App/modules/manegerHome/widgets/addCourseDialog.dart';
import '../../../core/utils/helperFunctions.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/imagePaths.dart';
import '../../widgets/customButton.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ManagerHomeController>();
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: getMediaQueryWidth(context: context, value: 40),
                top: getMediaQueryHeight(context: context, value: 80)),
            child: Row(
              children: [
                SvgPicture.asset(
                  ImagePaths.blackCourseIcon,
                  height: 32.spMin,
                  width: 32.spMin,
                ),
                SizedBox(
                  width: getMediaQueryWidth(context: context, value: 8),
                ),
                Text(
                  "Courses",
                  style: TextStyle(
                      fontSize: 32.spMin,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const Spacer(),
                CustomButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return AddCourseDialog(
                            controller: controller,
                          );
                        });
                  },
                  text: 'Add Course',
                  width: getMediaQueryWidth(context: context, value: 248),
                  color: buttonColor,
                ),
                SizedBox(
                  width: getMediaQueryWidth(context: context, value: 120),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
