import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/utils/helperFunctions.dart';
import '../../../../core/values/colors.dart';
import '../../../../routes/routes.dart';
import '../../../widgets/customButton.dart';
import '../controller.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.controller,
    required this.percentage,
    required this.randomNumber,
    required this.index,
  });

  final TraineeLearninController controller;
  final double percentage;
  final int randomNumber;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: cardBackgroundColor,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: ImageNetwork(
              image: controller.myLearnings[index].imageUrl,
              width: 200,
              height: getMediaQueryHeight(context: context, value: 210),
              fitWeb: BoxFitWeb.cover,
            ),
          ),
          SizedBox(
            width: getMediaQueryWidth(context: context, value: 16),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getMediaQueryHeight(context: context, value: 9),
              ),
              Text(
                controller.myLearnings[index].name,
                style: TextStyle(
                  fontSize: 20.spMin,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: getMediaQueryHeight(context: context, value: 32),
              ),
              LinearPercentIndicator(
                barRadius: const Radius.circular(20.0),
                width: getMediaQueryWidth(context: context, value: 380),
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2000,
                percent: percentage,
                center: Text(
                  "$randomNumber%",
                  style: TextStyle(
                      fontSize: 8.spMin,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                progressColor: indicatorEnableColor,
                backgroundColor: indicatorNotEnabledColor,
              ),
              SizedBox(
                height: getMediaQueryHeight(context: context, value: 32),
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: ImageNetwork(
                      image: controller.myLearnings[index].advisorImgUrl,
                      width: getMediaQueryWidth(context: context, value: 48),
                      height: getMediaQueryHeight(context: context, value: 55),
                      fitWeb: BoxFitWeb.fill,
                    ),
                  ),
                  SizedBox(
                    width: getMediaQueryWidth(context: context, value: 8),
                  ),
                  Text(
                    'By',
                    style: TextStyle(
                        fontSize: 12.spMin,
                        fontWeight: FontWeight.w400,
                        color: trainingDescriptionColor),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    controller.myLearnings[index].advisorName,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 12.spMin,
                      fontWeight: FontWeight.w400,
                      color: trainingAdvisorNameColor,
                    ),
                  ),
                  SizedBox(
                    width: getMediaQueryWidth(context: context, value: 64),
                  ),
                  CustomButton(
                    onPressed: () {
                      Get.rootDelegate.toNamed(
                        Routes.TRAINING_DETAILS_AFTER_RECORDING,
                        arguments: {
                          'trainingObject': controller.myLearnings[index],
                        },
                      );
                    },
                    text: 'Continuation',
                    width: getMediaQueryWidth(context: context, value: 150),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
