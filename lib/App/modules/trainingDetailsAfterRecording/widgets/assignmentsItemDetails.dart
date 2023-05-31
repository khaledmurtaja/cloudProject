import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utils/helperFunctions.dart';
import '../../../../core/values/colors.dart';
import '../../../widgets/customButton.dart';
import '../controller.dart';

class AssignmentsItemDetails extends StatelessWidget {
  const AssignmentsItemDetails({
    super.key,
    required this.controller,
 
  });

  final TrainingDetaileAfterRecordingController controller;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          'Assignments',
          style: TextStyle(
            fontSize: 35.spMin,
            fontWeight: FontWeight.w600,
            color: titleColor,
          ),
        ),
        SizedBox(
          height: getMediaQueryHeight(
              context: context, value: 20),
        ),
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 15.0),
            Column(
              children: [
                CustomButton(
                  width: getMediaQueryWidth(
                      context: context,
                      value: 150),
                  onPressed: () =>
                      controller.pickFile(),
                  text: 'Choose File',
                ),
                SizedBox(height: 16.0),
                Obx(() => controller
                            .selectedFile
                            .value !=
                        null
                    ? Text(controller
                        .selectedFile
                        .value!
                        .name)
                    : const Text(
                        'No file selected')),
                const SizedBox(height: 16.0),
                CustomButton(
                  width: getMediaQueryWidth(
                      context: context,
                      value: 150),
                  onPressed: () =>
                      controller.uploadFile(),
                  text: 'Upload File',
                ),
              ],
            ),
            const SizedBox(width: 15.0),
          ],
        ),
      ],
    );
  }
}
