import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:getx_architecture/App/modules/advisorHome/controller.dart';
import 'package:getx_architecture/App/modules/advisorHome/widgets/courseItem.dart';

class MyCourses extends StatelessWidget {
  const MyCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          SizedBox(height: 163.h,),
          Text(
              "My Courses",
            style: TextStyle(
              color: Colors.black,
              fontSize: 32.spMin,
              fontWeight: FontWeight.w700
            ),
          ),
          GetBuilder<AdvisorController>(
            builder: (controller) {
              if (controller.gettingTrainingsLoading) {
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
  }
}
