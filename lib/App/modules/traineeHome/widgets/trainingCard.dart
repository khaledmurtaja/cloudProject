import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';

import '../../../../core/utils/helperFunctions.dart';
import '../../../../core/values/colors.dart';
import '../../../data/models/training.dart';
import '../../../widgets/customButtonWidget.dart';
import '../controller.dart';

class TrainingCard extends StatelessWidget {
  const TrainingCard({
    super.key,
    required this.training,
    required this.controller,
  });

  final Training training;
  final TraineeHomeController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/trainingDetaile', arguments: [
          {'trainingObject': training}
        ]);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: ImageNetwork(
                image: training.imageUrl,
                width: 282,
                height: getMediaQueryHeight(context: context, value: 171),
                fitWeb: BoxFitWeb.cover,
              ),
            ),
            SizedBox(
              height: getMediaQueryHeight(context: context, value: 16),
            ),
            SizedBox(
              width: 282,
              child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    training.name,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 20.spMin, fontWeight: FontWeight.w500),
                  )),
            ),
            SizedBox(
              height: getMediaQueryHeight(context: context, value: 8),
            ),
            SizedBox(
              width: 282,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  training.description,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 12.spMin,
                      fontWeight: FontWeight.w400,
                      color: trainingDescriptionColor),
                ),
              ),
            ),
            SizedBox(
              height: getMediaQueryHeight(context: context, value: 8),
            ),
            training.isPaidCourse
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '\$${training.price}',
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 20.spMin,
                        fontWeight: FontWeight.w600,
                      ),
                    ))
                : Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text(
                          'Free',
                          style: TextStyle(
                              fontSize: 20.spMin,
                              fontWeight: FontWeight.w600,
                              color: Colors.green),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '\$${training.price}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 20.spMin,
                            fontWeight: FontWeight.w400,
                            color: trainingDescriptionColor,
                          ),
                        ),
                      ],
                    )),
            SizedBox(
              height: getMediaQueryHeight(context: context, value: 16),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
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
                      training.advisorName,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 12.spMin,
                        fontWeight: FontWeight.w400,
                        color: trainingAdvisorNameColor,
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: getMediaQueryHeight(context: context, value: 16),
            ),
            GetBuilder<TraineeHomeController>(
                builder: (newController) => Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: CustomButton(
                        onPressed: () {
                          controller.showTrainingDatesDialog(
                              context, training, controller);
                        },
                        text: 'Subscribe Now',
                        width: 250,
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}
