import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/values/colors.dart';
import '../controller.dart';

class AdvisorItem extends StatelessWidget {
  const AdvisorItem({
    super.key,
    required this.controller,
  });

  final TrainingDetaileBeforeRecordingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 100),
      child: controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Column(
                children: [  
                  Image.asset('assets/images/user/user1.png'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    controller.advisor!.name,
                    style: TextStyle(
                        fontSize: 25.spMin,
                        fontWeight: FontWeight.w600,
                        color: titleColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    controller.advisor!.field,
                    style: TextStyle(
                        fontSize: 15.spMin,
                        fontWeight: FontWeight.w500,
                        color: descriptionColor),
                  ),
                ],
              ),
            ),
    );
  }
}
