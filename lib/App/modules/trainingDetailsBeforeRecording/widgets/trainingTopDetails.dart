import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_architecture/core/values/colors.dart';

import '../../../../core/utils/helperFunctions.dart';
import '../../../data/models/training.dart';
import '../../../widgets/customButtonWidget.dart';
import '../../traineeHome/controller.dart';
import '../controller.dart';

class TrainingTopDetails extends StatelessWidget {
  const TrainingTopDetails({
    super.key,
    required this.controller, required this.training,
  });
  final Training training;
  final TrainingDetaileBeforeRecordingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 100, top: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.training!.name,
            style: TextStyle(
                fontSize: 50.spMin,
                fontWeight: FontWeight.w600,
                color: titleColor),
          ),
          SizedBox(
            height: getMediaQueryHeight(context: context, value: 24),
          ),
          SizedBox(
            width: getMediaQueryWidth(context: context, value: 1000),
            child: Text(
              controller.training!.description,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 20.spMin,
                  fontWeight: FontWeight.w400,
                  color: titleColor),
            ),
          ),
          SizedBox(
            height: getMediaQueryHeight(context: context, value: 50),
          ),
          Row(
            children: [
              Text(
                'Offered by',
                style: TextStyle(
                    fontSize: 20.spMin,
                    fontWeight: FontWeight.w500,
                    color: titleColor),
              ),
              SizedBox(
                width: 20,
              ),
              Image.asset('assets/images/harvard.png')
            ],
          ),
          SizedBox(
            height: getMediaQueryHeight(context: context, value: 50),
          ),
          Text(
            '25,463 already subscribe',
            style: TextStyle(fontSize: 20.spMin, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: getMediaQueryHeight(context: context, value: 20),
          ),
          GetBuilder<TraineeHomeController>(
              builder: (newController) => Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: CustomButton(
                      onPressed: () {
                        newController.showTrainingDatesDialog(
                            context, training, newController);
                      },
                      text: controller.training!.isPaidCourse
                          ? '${controller.training!.price}\$ Subscribe Now'
                          : '(Free) Subscribe Now',
                      width: 220,
                    ),
                  )),
        ],
      ),
    );
  }
}
