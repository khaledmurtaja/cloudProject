import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/trainingDetailsAfterRecording/widgets/assignmentsItemDetails.dart';
import 'package:getx_architecture/App/modules/trainingDetailsAfterRecording/widgets/sideCard.dart';
import 'package:getx_architecture/core/utils/helperFunctions.dart';
import 'package:getx_architecture/core/values/colors.dart';

import '../../widgets/customAppBar.dart';
import '../../widgets/customButton.dart';
import '../trainingDetailsBeforeRecording/widgets/customTabBar.dart';
import '../trainingDetailsBeforeRecording/widgets/tabBarViewItem.dart';
import 'controller.dart';

class TrainingDetaileAfterRecordingScreen
    extends GetView<TrainingDetaileAfterRecordingController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: EdgeInsets.only(
                      left: getMediaQueryWidth(context: context, value: 100)),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: getMediaQueryHeight(
                                      context: context, value: 30),
                                ),
                                Text(
                                  'Training',
                                  style: TextStyle(
                                    fontSize: 32.spMin,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: getMediaQueryHeight(
                                      context: context, value: 30),
                                ),
                                Text(
                                  controller.training!.name,
                                  style: TextStyle(
                                    fontSize: 28.spMin,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: getMediaQueryHeight(
                                      context: context, value: 30),
                                ),
                                Image.asset('assets/images/playVideo.png'),
                                SizedBox(
                                  height: getMediaQueryHeight(
                                      context: context, value: 30),
                                ),
                                SizedBox(
                                  width: getMediaQueryWidth(
                                      context: context, value: 500),
                                  child: const CustomTabBar(
                                    text1: 'About',
                                    text2: 'Assignments',
                                    text3: 'Details',
                                    text4: 'Resources',
                                  ),
                                ),
                                SizedBox(
                                  height: getMediaQueryHeight(
                                      context: context, value: 30),
                                ),
                                SizedBox(
                                  width: 700,
                                  height: 400,
                                  child: TabBarView(
                                    children: [
                                      TabBarViewItem(
                                          training: controller.training!),
                                      AssignmentsItemDetails(controller: controller, ),
                                      TabBarViewItem(
                                          training: controller.training!),
                                      TabBarViewItem(
                                          training: controller.training!),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: getMediaQueryHeight(
                                  context: context,
                                  value: 100,
                                ),
                              ),
                              Text(
                                'Training Content',
                                style: TextStyle(
                                  fontSize: 28.spMin,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: getMediaQueryHeight(
                                  context: context,
                                  value: 20,
                                ),
                              ),
                              SideCard(
                                controller: controller,
                                lessonNum: 1,
                              ),
                              SizedBox(
                                height: getMediaQueryHeight(
                                  context: context,
                                  value: 24,
                                ),
                              ),
                              SideCard(
                                controller: controller,
                                lessonNum: 2,
                              ),
                              SizedBox(
                                height: getMediaQueryHeight(
                                  context: context,
                                  value: 24,
                                ),
                              ),
                              SideCard(
                                controller: controller,
                                lessonNum: 3,
                              ),
                              SizedBox(
                                height: getMediaQueryHeight(
                                  context: context,
                                  value: 24,
                                ),
                              ),
                              SideCard(
                                controller: controller,
                                lessonNum: 4,
                              ),
                              SizedBox(
                                height: getMediaQueryHeight(
                                  context: context,
                                  value: 24,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

