import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/customAppBar.dart';
import '../traineeHome/controller.dart';
import '../traineeHome/widgets/trainingCard.dart';
import 'controller.dart';

class AllTrainingsScreen extends GetView<AllTrainingsController> {
  const AllTrainingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(controller.trainingType);
    return Scaffold(
      appBar: CustomAppBar(),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 60,
                        top: 20,
                      ),
                      child: Text(
                        controller.trainingType == 'RecommendedTrainings'
                            ? 'Recommended for you'
                            : 'New Trainings',
                        style: TextStyle(
                            fontSize: 28.spMin, fontWeight: FontWeight.w600),
                      ),
                    ),
                    GetBuilder<TraineeHomeController>(
                      builder: (traineeHomeController) => Padding(
                        padding: const EdgeInsets.only(
                            left: 60, right: 60, top: 20, bottom: 20),
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount:
                              controller.trainingType == 'RecommendedTrainings'
                                  ? traineeHomeController
                                      .recommendedTrainings.length
                                  : traineeHomeController.newTrainings.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 2.8 / 3,
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemBuilder: (BuildContext context, int index) {
                            return TrainingCard(
                              training: controller.trainingType ==
                                      'RecommendedTrainings'
                                  ? traineeHomeController
                                      .recommendedTrainings[index]
                                  : traineeHomeController.newTrainings[index],
                              controller: traineeHomeController,
                              imageHeight: 200,
                              imageWidth: 320,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
