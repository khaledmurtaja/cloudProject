import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/manegerHome/controller.dart';
import 'package:getx_architecture/App/modules/manegerHome/widgets/addCourseDialog.dart';
import 'package:getx_architecture/App/modules/manegerHome/widgets/courseItem.dart';
import '../../../core/utils/helperFunctions.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/imagePaths.dart';
import '../../widgets/customButton.dart';

class CoursesPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagerHomeController>(
      builder: (controller){
        return  Scaffold(
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
              SizedBox(
                height: 40.h,
              ),
              GetBuilder<ManagerHomeController>(
                builder: (controller) {
                  if (controller.gettingCoursesLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return Expanded(
                      child: GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 407,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                          itemCount: controller.trainings.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return CourseItem(
                              imageUrl: controller.trainings[index].courseImageUrl,
                              description: controller.trainings[index].description,
                              price: controller.trainings[index].price,
                              isPaid: controller.trainings[index].isPaidCourse,
                              advisorName: controller.trainings[index].advisorName,
                            );
                          }),
                    );
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}
