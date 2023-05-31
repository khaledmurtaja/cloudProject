import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:getx_architecture/App/modules/advisorHome/controller.dart';
import 'package:getx_architecture/App/modules/advisorHome/widgets/courseItem.dart';
import 'package:getx_architecture/App/modules/advisorHome/widgets/studentsItem.dart';

class MyStudents extends StatelessWidget {
  const MyStudents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          SizedBox(
            height: 163.h,
          ),
          Text(
            "My Students",
            style: TextStyle(
                color: Colors.black,
                fontSize: 32.spMin,
                fontWeight: FontWeight.w700),
          ),
          GetBuilder<AdvisorController>(
            builder: (controller) {
              print(controller.students.length);
              if (controller.gettingStudentsLoading) {
                return const CircularProgressIndicator();
              } else {
                return Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 407,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: controller.students.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return StudentsItem(
                          controller: controller,
                          imageUrl: controller.students[index].userImgUrl,
                          name: controller.students[index].name,
                          email: controller.students[index].email,
                          field: controller.students[index].field,
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
