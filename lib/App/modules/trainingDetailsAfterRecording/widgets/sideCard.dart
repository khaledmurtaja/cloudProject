import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/helperFunctions.dart';
import '../../../../core/values/colors.dart';
import '../controller.dart';

class SideCard extends StatelessWidget {
  const SideCard({
    super.key,
    required this.controller, required this.lessonNum,
  });

  final TrainingDetaileAfterRecordingController controller;
// final String trainingName;
final int lessonNum;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: cardBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(
          left: getMediaQueryWidth(
              context: context, value: 35),
          right: getMediaQueryWidth(
              context: context, value: 35),
          top: getMediaQueryHeight(
              context: context, value: 40),
          bottom: getMediaQueryHeight(
              context: context, value: 40),
        ),
        child: Text(
          '${controller.training!.name.substring(0, 20)}' +
              ' lesson $lessonNum',
          maxLines: 1,
          style: TextStyle(
            fontSize: 24.spMin,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
