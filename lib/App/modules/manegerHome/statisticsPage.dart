import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/App/modules/manegerHome/controller.dart';
import 'package:getx_architecture/App/modules/manegerHome/widgets/dashBoardItemCard.dart';

import '../../../core/utils/helperFunctions.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ManagerHomeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: getMediaQueryHeight(context: context, value: 80),
        ),
        Text(
          "Dashboard",
          style: TextStyle(fontSize: 32.spMin, fontWeight: FontWeight.w600),
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
              value: "30",
              isLoading: true,
            ),
            SizedBox(
              width: getMediaQueryWidth(context: context, value: 24),
            ),
            DashBoardItemCard(
              title: "Requests",
              value: "90",
              isLoading: true,
            ),
          ],
        )
      ],
    );
  }
}
