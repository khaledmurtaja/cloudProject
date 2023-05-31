import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/manegerHome/controller.dart';
import 'package:getx_architecture/App/modules/manegerHome/widgets/traineeItem.dart';
import '../../../core/utils/helperFunctions.dart';
import '../../../core/values/imagePaths.dart';

class TraineesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagerHomeController>(
      builder: (controller) {
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
                      "Trainees",
                      style: TextStyle(
                          fontSize: 32.spMin,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
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
                  if (controller.getTraineesLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 407,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: controller.trainees.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return TraineeItem(
                              usrImageUrl:
                                  controller.trainees[index].userImgUrl,
                              name: controller.trainees[index].name,
                              field: controller.trainees[index].field,
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
