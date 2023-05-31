import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/manegerHome/controller.dart';
import 'package:getx_architecture/App/modules/manegerHome/widgets/courseItem.dart';
import 'package:getx_architecture/App/modules/manegerHome/widgets/dashBoardItemCard.dart';

import '../../../core/utils/helperFunctions.dart';
import '../../../core/values/imagePaths.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> courses = [];
    return GetBuilder<ManagerHomeController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getMediaQueryHeight(context: context, value: 80),
              ),
              Text(
                "Dashboard",
                style:
                    TextStyle(fontSize: 32.spMin, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  DashBoardItemCard(
                    title: "Advisors",
                    value: controller.advisorCountText,
                    isLoading: controller.isAdvisorLoading,
                  ),
                  SizedBox(
                    width: getMediaQueryWidth(context: context, value: 24),
                  ),
                  DashBoardItemCard(
                    title: "Trainees",
                    value: controller.traineeCountText,
                    isLoading: controller.isTraineeLoading,
                  ),
                ],
              ),
              SizedBox(
                height: getMediaQueryHeight(context: context, value: 24),
              ),
              Row(
                children: [
                  DashBoardItemCard(
                    title: "Courses",
                    value: controller.coursesCountText,
                    isLoading: controller.isCoursesLoading,
                  ),
                  SizedBox(
                    width: getMediaQueryWidth(context: context, value: 24),
                  ),
                  DashBoardItemCard(
                    title: "Requests",
                    value: controller.requestsCountText,
                    isLoading: controller.isRequestsLoading,
                  ),
                ],
              ),
              SizedBox(
                height: 80.h,
              ),
              Row(
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
                  Padding(
                    padding: EdgeInsets.only(right: 20.spMin),
                    child: InkWell(
                      onTap: () {
                        controller.onCoursesSelected();
                      },
                      child: Row(
                        children: const [
                          Text(
                            'More',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              GetBuilder<ManagerHomeController>(builder: (controller) {
                if (controller.gettingCoursesLoading) {
                  return const CircularProgressIndicator();
                } else {
                  if (controller.trainings.isEmpty) {
                    return const Text("No data");
                  } else {
                    for (var element in controller.trainings) {
                      courses.add(Expanded(
                        child: CourseItem(
                          imageUrl: element.courseImageUrl,
                          description: element.description,
                          price: element.price,
                          isPaid: element.isPaidCourse,
                          advisorName: element.advisorName,
                        ),
                      ));
                      if (courses.length >= 3) {
                        break;
                      }
                    }
                    return Row(
                      children: courses,
                    );
                  }
                }
              }),

            ],
          ),
        );
      },
    );
  }
}
